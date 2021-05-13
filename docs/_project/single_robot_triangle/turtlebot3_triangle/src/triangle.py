#!/usr/bin/env python

import rospy
from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Twist
import numpy as np
import math

J_previous = float('inf')                                                     #previous cost function

class triangle:
	def __init__(self):
		self.no_of_samples = 5
		
	def callback(self, msg):
		self.data = msg                                                       #copy msg because can't access it outside callback function

		self.previous_samples = np.zeros((self.no_of_samples))                #array to store previous 3 samples
		self.next_samples = np.zeros((self.no_of_samples))                    #array to store next 3 samples
		self.nz = 0                                                           #number of unwanted zeros to filter out extra zeros while calculating average
	
		#variables related to overlap case
		self.overlap = False                                                  #boolean variable to indicate if overlap has occured
		self.overlap_start = -1000											  #index indicating starting point of samples during overlap case
		self.overlap_data = []												  #list containing previous samples in case of overlap
		self.overlap_angles = []                                              #list containing previous samples angles in overlap case
		self.combine_data = False

		self.d = []															  #list to store average distance/range values of one obstacle 
		self.avg_d = []
		self.angles = []													  #list to store angle values of obstacles
		self.avg_angles = [] 												  #list to store average angle of obstacle
		self.lidar_values = []                                                #list to store individual obstacle rangle values
		self.lidar_angles = []                                                #list to store individual obstacle angle values
		self.r = rospy.Rate(5)											  #1 hz or 1 sec delay
	
		self.total = 0

		self.pub = rospy.Publisher('cmd_vel', Twist, queue_size = 1)          #Publishing to /cmd_vel topic


		#Variables related to controller implementation
		self.d_bar = 0														  #Distance between two obstacles
		self.alpha1_bar = math.radians(330)
		self.alpha2_bar = math.radians(30)
		self.v_k = 0                                                          #linear velocity input control
		self.w_k = 0														  #angular velocity input control
		self.u_k = []                                                         #control inputs list

		self.gamma = 0.1													  #parameter to modify cost function to get global minima

		self.v_max = 0.15													  #not sure about these values, confirm once
		self.w_max = 1.5													  #not sure about these values, confirm once

		self.x_dot = []

		self.J = float('inf')												  #cost function
		self.J_dot = 0														  #cost function derivative

		self.eps = (10)**(-5)

		

		rospy.loginfo("Loop entered")
	


		for i in range(len(self.data.ranges)):

			self.calculate_previous(i)                                                  #function call to calculate 5 previous samples
			self.calculate_next(i)                                                      #function call to calculate 5 next samples

			self.invalid_previous = all(np.nan_to_num(self.previous_samples)==0)        #boolean variable to indicate if previous few samples are invalid
			self.invalid_next = all(np.nan_to_num(self.next_samples)==0)                #boolean variable to indicate if next few samples are invalid

			#condition to check overlap case
			if(i==0 and not(self.invalid_next) and not(self.invalid_previous)):
				self.overlap =  True 
				self.overlap_start = 359 

			#condition to check if starting index of overlap data is reached, if so combine data and ignore rest of the samples
			if ((self.overlap_start!=-1000) and (i >=self.overlap_start)):
				if(i==self.overlap_start):
					self.combine_data = True											#incase of overlap, time to combine the data
				elif(i>self.overlap_start):
					continue															#skip next samples

			#invalid sample case where next five samples and previous five samples are nan
			if(self.invalid_previous and self.invalid_next):                            #invalid lidar data => skip
				continue

			#invalid sample case where current sample is nan
			elif np.nan_to_num(self.data.ranges[i]) == 0:                               #invalid lidar data => skip
				continue		
		
			#valid sample data, either previous five samples are valid or next five samples are vlid
			elif(np.nan_to_num(self.data.ranges[i])!= 0 or self.invalid_previous or self.invalid_next):         #valid lidar current data
				if(self.overlap and not(self.invalid_previous)):                        #if overlap case, find overlap data starting index
					self.overlap = False
					#find starting point in case of overlapping data
					while(not(all(np.nan_to_num(self.data.ranges[self.overlap_start-self.no_of_samples:self.overlap_start])==0))):
						self.overlap_start-=1
					self.overlap_data = list(np.nan_to_num(self.data.ranges[self.overlap_start:]))
					self.overlap_angles = list(range(self.overlap_start, 360))
					#print("-----------Overlap data is:-------------- ",self.overlap_data)
					#print("Range at %d degrees: %f" %(i, np.nan_to_num(self.data.ranges[i])))
					self.lidar_values.append(self.data.ranges[i])
					self.lidar_angles.append(i)
					continue
				elif(self.invalid_next or self.combine_data):                                             
					if(self.combine_data):												#if current sample is start of overlap data
						self.combine_data = False
						rospy.loginfo("Combining data: Overlap case")
						self.d[0] = self.d[0] + self.overlap_data
						self.angles[0] = self.angles[0] + self.overlap_angles
					else:															    #valid current data and end of valid data
						rospy.loginfo("End of valid data case")
						print(self.previous_samples, self.next_samples)
						self.d.append(self.lidar_values)								#append current obstacle range values
						self.angles.append(self.lidar_angles)                           #append current obstacle angle values
						self.lidar_values = []
						self.lidar_angles = []
					continue
				elif((self.invalid_previous) or (not(self.invalid_previous) and not(self.invalid_next))):                      #valid current data and beginning of valid data
					#print("Range at %d degrees: %f" %(i, np.nan_to_num(self.data.ranges[i])))
					self.lidar_values.append(self.data.ranges[i])
					self.lidar_angles.append(i)


		
		
		print(self.d)	
		self.calculate_average()                                                        #function call to calculate average LIDAR range and angles of obstacles

		print("There are %d obstacles:"%(len(self.d)))
		
		print("Distance array for this scan is: ", self.avg_d)
		print("Angles array for this scan is: ", self.avg_angles)

		self.controller()

		twist = Twist()
		twist.linear.x  = 0.0;		twist.angular.z = 0.0

		self.r.sleep()


	def calculate_previous(self, index_previous):
		if(index_previous<self.no_of_samples):
			if(index_previous==0):
				self.previous_samples = self.data.ranges[-self.no_of_samples:]                #get last samples of array
			else:
				self.previous_samples = np.hstack((self.data.ranges[-self.no_of_samples+index_previous:], self.data.ranges[:index_previous]))  #samples of beginning and end of array
		else:
			self.previous_samples = self.data.ranges[index_previous-self.no_of_samples:index_previous]          #normal case

	def calculate_next(self, index_next):
		if(index_next>=(len(self.data.ranges)-self.no_of_samples)):
			self.next_samples = np.hstack((self.data.ranges[index_next+1:], self.data.ranges[: self.no_of_samples - (len(self.data.ranges)-(index_next+1))]))
		else:
			self.next_samples = self.data.ranges[index_next+1:index_next+self.no_of_samples+1]

	def calculate_average(self):
		for k in range(len(self.d)):
			self.nz = self.d[k].count(0)
			# print("####################################################")
			# print(self.nz)
			# print(len(self.d[k]))
			# print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
			self.avg_d.append((sum(self.d[k])/(len(self.d[k])-self.nz)))                #average range calculation
			#average angle calculation                                                   
			if(self.overlap_start!=-1000 and k == 0):                                   #overlap case
				for m in self.angles[k]:
					if(m>90):
						self.total = m - 360
					else:
						self.total += m
				if(self.total<0):
					self.total += 360
				self.avg_angles.append(self.total/(len(self.angles[k]))) 
			else:
				self.avg_angles.append((sum(self.angles[k]))/(len(self.angles[k])))     #normal case


	#Controller implementation starts from here, haven't tested this part of the code
	def controller(self):
		global J_previous
		self.avg_d.reverse()																	#d_1, d_2 are in reverse order in the list
		self.avg_angles.reverse()                                                            #alpha_1, alpha_2 are in reverse order in the list

		#confirm if here angles has to be converted to radians
		self.d_bar = math.sqrt(self.avg_d[0]**2 + self.avg_d[1]**2 - 2*self.avg_d[0]*self.avg_d[1]*math.cos(math.radians(abs(self.avg_angles[0] -  self.avg_angles[1]))))
		
		
		self.compute_v()																		#compute control input linear velocity
		self.compute_w()																		#compute control input angular velocity
		self.u_k.append(self.v_k)
		self.u_k.append(self.w_k)

		# self.compute_dynamics()

		self.compute_J()
		self.compute_Jdot()
		print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
		print("Cost function this iteration:", self.J)
		print("Cost function previous interation", J_previous)
		print("Cost function derivative", self.J_dot)
		print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")


		twist = Twist()

		#exiting condition, write code for it properly?!
		if(self.J_dot<=self.eps and (J_previous-self.J) <=self.eps):
			#compute_Jdot()
			#break out of the loop?!
			#stop the robot and break out of code
			twist.linear.x  = 0.0;		twist.angular.z = 0.0;                         #Stopping the bot condition
		else:
			print("#####################################################")
			print(self.v_k)
			print(self.w_k)
			print("#####################################################")
			twist.linear.x = self.v_k
			twist.angular.z = self.w_k
		

		J_previous = self.J                                                             #store previous cost function for next function call
		


		self.pub.publish(twist) 
		

	def compute_v(self):
		self.v_k = 0.5*((self.avg_d[0] - self.d_bar)*math.cos(math.radians(self.avg_angles[0])) + self.gamma*(self.avg_d[1] - self.d_bar)*math.cos(math.radians(self.avg_angles[1])))
		print("Function call linear velocity", self.v_k)
		print("Max linear velocity", self.v_max)
		if(abs(self.v_k)>self.v_max):
			self.v_k = (self.v_k/abs(self.v_k))*self.v_max                                             #getting way higher values, so used remainder 
			#elf.v_k = self.v_k%self.v_max
		else:
			return

	def compute_w(self):
		self.w_k = 0.5*(math.radians(self.avg_angles[0]+self.avg_angles[1])-2*math.pi)
		print("Function call angular velocity", self.w_k)
		print("Max angular velocity", self.w_max)
		if (abs(self.w_k) > self.w_max):
			self.w_k = (self.w_k/abs(self.w_k))*self.w_max
		else:
			return

	# def compute_dynamics(self):
	# 	self.x_dot.append(-self.v_k*math.cos(math.radians(self.avg_angles[0])))
	# 	self.x_dot.append(-self.v_k*math.cos(math.radians(self.avg_angles[1])))
	# 	self.x_dot.append(-self.w_k)
	# 	self.x_dot.append(-self.w_k)

	def compute_J(self):
		self.J = (self.avg_d[0] - self.d_bar)**2 + self.gamma*(self.avg_d[1] - self.d_bar)**2 + (math.radians(self.avg_angles[0]) - self.alpha1_bar)**2 + \
		          (math.radians(self.avg_angles[1]) - self.alpha2_bar)**2

	def compute_Jdot(self):
		#self.J_dot = 2*(self.avg_d[0]-self.d_bar)*self.x_dot[0] + self.gamma*2*(self.avg_d[1]-self.d_bar)*self.x_dot[1] + 2*(math.radians(self.avg_angles[0]) - self.alpha1_bar)*self.x_dot[2] + \
		#             2*(math.radians(self.avg_angles[1])-self.alpha2_bar)*self.x_dot[3]
		self.J_dot = -((self.avg_d[0] - self.d_bar)*math.cos(math.radians(self.avg_angles[0])) + (self.avg_d[1] - self.d_bar)*math.cos(math.radians(self.avg_angles[1])))**2 \
					 - (math.radians(self.avg_angles[0]+self.avg_angles[1]) - 2*math.pi)**2 

#-----------------------------------------------------------------------------------------------------
#haven't tested the code above

def main():
	rospy.init_node('formation', anonymous=True)                                        #creating a node "formation"

	formation = triangle()
	while not rospy.is_shutdown():	
		rospy.loginfo("Loop Entered")	
		rospy.Subscriber("/scan_filtered", LaserScan, formation.callback)
		rospy.spin()


if __name__ == '__main__':
	main()

#-------------------------------------------------------------------------------------------------

