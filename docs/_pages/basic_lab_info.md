# Basic Information About Lab Resources

This page lists all available resources in the lab.



## Hardware and OS

**Computers:**

- Lambda Workstation x1
- Dell Workstation x3
- Dell Monitors x6

All computers are equipped with Ubuntu 18.04.



**Robots:**

- Turtlebot Burger x3
- Tutlebot Waffle x3
- Turtlebot robotic arm x1

All Turtlebot robots are equipped with  Raspberry Pi OS based on Debain 9.



Jetson Nano:

- Xxx

Other:

- eye tracker?



## Administrator Account

For better management, each computer has the administrator account called `larx`. The administrator is response for managing packages, editing configuration files, installing a program from source. The administrator user name and password for all four computers.

- username: `larx`
- password:  `xxxxxxxxx`



## Network Configuration

All four computers are connected to NYU wifi with the following IP address:

- Dell #1: `172.24.113.157`
- Dell #2: `172.24.113.158`
- Lambda: `172.24.113.159`

**Note:** Dell #3 is used for ROS and other development. So it is equipped with a router to form the lab local wireless network (LAN). The LAN is used for multi-robot controls. The local AP and password are

- WiFi name: `TP-Link_A914`
- Password: `80187233`

**Note:** All IP addresses are private. To access computers remotely via *SSH*, make sure to first connect to NYU network or NYU VPN.