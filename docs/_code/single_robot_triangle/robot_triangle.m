classdef robot_triangle
    %robot_triangle Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        PB = [2; 1.8];      % position of object B
        PC = [0.6; 1];      % position of object C (human)
        v_max = 1;  % max linear velocity
        w_max = 1;  % max angular velocity
        dt = 0.1;   % discrete time steps for GD controller
        theta_0 = deg2rad(10);   % initial theta(0)
        alp1_0;     % initial alpha_1(0)
        alp2_0;     % initial alpha_2(0)
        Delta1;     % angle constant for edge AB
        Delta2;     % angle constant for edge AC
        d_bar;      % desired length for edge AB and AC
        alp_bar = pi/6;     % desired anglle
    end
    
    methods
        function obj = robot_triangle(PA)
            %robot_triangle Construct an instance of this class
            
            % compute alp1_0 and alp2_0
            AB = obj.PB - PA;
            obj.alp1_0 = acos([1,0]*AB / norm(AB));
            AC = obj.PB - PA;
            obj.alp2_0 = acos([1,0]*AC / norm(AC));
            
            % compute Delta1 and Delta2
            obj.Delta1 = obj.alp1_0 + obj.theta_0;
            obj.Delta2 = obj.alp2_0 + obj.theta_0;
            
            % compute d_bar
            obj.d_bar = sqrt(norm(AB)^2+norm(AC)^2-2*norm(AB)*norm(AC) ...
                *cos(obj.alp2_0 - obj.alp1_0));
            
        end
        
        
        function [v] = compute_v(obj, d1, d2, alp1, alp2)
            % This function computes the control v
            v = (d1-obj.d_bar)*cos(alp1) + (d2-obj.d_bar)*cos(alp2);
            v = obj.norm_v( v/2 );
        end
        
        function [w] = compute_w(obj, alp1, alp2)
            % This function computes the control w
            w = obj.norm_w( (alp1+alp2)/2 );
        end
        
        function [xdot] = compute_dynamics(obj, alp1, alp2, v, w)
            % This function computes dot{d1}, dot{d2}, dot{alp1}, dot{alp2}
            xdot = zeros(4, 1);
            xdot(1) = -v * cos(alp1);
            xdot(2) = -v * cos(alp2);
            xdot(3) = -w; 
            xdot(4) = -w;
        end
        
        function [Jdot] = compute_Jdot(obj, d1, d2, alp1, alp2, v, w)
            % This function computes dot{j}
            [xdot] = obj.compute_dynamics(alp1, alp2, v, w);
            
            Jdot = 2*(d1-obj.d_bar)*xdot(1) + 2*(d2-obj.d_bar)*xdot(2) ...
                + 2*(alp1+obj.alp_bar)*xdot(3) + 2*(alp2-obj.alp_bar)*xdot(4);
        end
        
        
        function v_norm = norm_v(obj, v)
            % This function normalize the linear velocity
            if abs(v) > obj.v_max
                v_norm = v / obj.v_max;
            else
                v_norm = v;
            end
        end
        
        function w_norm = norm_w(obj, w)
            % This function normalize the angular velocity
            if abs(w) > obj.w_max
                w_norm = w / obj.w_max;
            else
                w_norm = w;
            end
        end
        
        
        function plot_traj(obj, xtraj)
            % This function plots the trajectory of the robot
            h = figure;
            
            traj_length = size(xtraj, 2);
            for i = 1: traj_length
                clf(h);
                
                % plot B and C
                obj.plot_rectangle(obj.PB);
                hold on 
                obj.plot_rectangle(obj.PC);
                axis equal
                
                % plot A and the trajectory points
                x = xtraj(1:2, i);
                alp1 = xtraj(3, i);
                
                obj.plot_rectangle(x);
                obj.plot_direction_bar(x, alp1);
                for j = 1: i
                    plot(xtraj(1, j), xtraj(2, j), 'rx', 'MarkerSize', 10);
                end 
                pause(0.5)
            end 
        end
        
        function plot_rectangle(obj, center)
            % This functioin plots a black rectangle to denote the robot or
            % the obstacle.
            % center is a 2x1 vector.
            a = 0.05;
            pos = [center-a; 2*a; 2*a]';
            rectangle('Position', pos, 'FaceColor','k', 'EdgeColor','k');
            
        end
        
        function plot_direction_bar(obj, center, alp1)
            % This function plots the directional bar for the robot
            % center is the starting point of the bar
            l = 0.15;
            angle = obj.alp1_0 - alp1 + obj.theta_0;
            end_pt = l *[ cos(angle); sin(angle)] + center;
            line([center(1) end_pt(1)], [center(2) end_pt(2)], ...
                'Color', 'k', 'LineWidth', 2);
        end
        
    end
end

