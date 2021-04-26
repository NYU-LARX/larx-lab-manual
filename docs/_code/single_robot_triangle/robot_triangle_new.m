classdef robot_triangle_new
    %robot_triangle Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        pA0;
        PB = [2; 2];      % position of object B
        PC = [1; 0.6];      % position of object C (human)
        v_max = 0.5;  % max linear velocity
        w_max = 0.5;  % max angular velocity
        dt = 0.1;   % discrete time steps for GD controller
        theta_0 = deg2rad(145);   % initial theta(0)
        alp1_0;     % initial alpha_1(0)
        alp2_0;     % initial alpha_2(0)
        Delta1;     % angle constant for edge AB
        Delta2;     % angle constant for edge AC
        d_bar;      % desired length for edge AB and AC
        alp1_bar = 11*pi/6;     % desired alpha1
        alp2_bar = pi/6;        % desired alpha2
        gam = 0.1;
    end
    
    methods
        function obj = robot_triangle_new(PA)
            %robot_triangle Construct an instance of this class
            obj.pA0 = PA;
            
            % compute alp1_0 and alp2_0
            
            [obj.alp1_0, obj.alp2_0] = obj.compute_alpha(PA, obj.theta_0);
            AB = obj.PB - PA;
            AC = obj.PC - PA;
            
            % compute Delta1 and Delta2
            obj.Delta1 = obj.alp1_0 + obj.theta_0;
            obj.Delta2 = obj.alp2_0 + obj.theta_0;
            
            % compute d_bar
            obj.d_bar = sqrt( norm(AB)^2+norm(AC)^2-2*norm(AB)*norm(AC) ...
                *cos(abs(obj.alp1_0-obj.alp2_0)) );
        end
        
        function [alp1 ,alp2] = compute_alpha(obj, x, theta)
            % This function computes alpha angle in the formation control
            % The angle alphe is in [0, 2*pi]
            % All angles are counted counter clockwise
            
            % 1. determine which quardant does the vector lie in A-x'y'
            % coordinate
            % 2. determine the angle
            
            nx = [cos(theta); sin(theta)];
            ny = [-sin(theta); cos(theta)];
            AB = obj.PB - x;
            AC = obj.PC - x;
            
            if nx'*AB >= 0 && ny'*AB >= 0       % first quadrant
                alp1 = acos(nx'*AB/norm(AB));
            elseif nx'*AB < 0 && ny'*AB >= 0    % second quadrant
                alp1 = acos(nx'*AB/norm(AB));
            elseif nx'*AB < 0 && ny'*AB < 0     % third quadrant
                alp1 = 2*pi-acos(nx'*AB/norm(AB));
            else                                % forth quadrant
                alp1 = 2*pi-acos(nx'*AB/norm(AB));
            end
            
            if nx'*AC >= 0 && ny'*AC >= 0       % first quadrant
                alp2 = acos(nx'*AC/norm(AC));
            elseif nx'*AC < 0 && ny'*AC >= 0    % second quadrant
                alp2 = acos(nx'*AC/norm(AC));
            elseif nx'*AC < 0 && ny'*AC < 0     % third quadrant
                alp2 = 2*pi-acos(nx'*AC/norm(AC));
            else                                % forth quadrant
                alp2 = 2*pi-acos(nx'*AC/norm(AC));
            end
        end
        
        function [alp] = proj_alp(obj, alp)
            % This function projects alp back to [0, 2*pi]
            if alp > 2*pi
                alp = alp - 2*pi;
            elseif alp < 0
                alp = alp + 2*pi;
            else
                % do nothing
            end
        end
        
        function [v] = compute_v(obj, d1, d2, alp1, alp2)
            % This function computes the control v
            v = (d1-obj.d_bar)*cos(alp1) + obj.gam*(d2-obj.d_bar)*cos(alp2);
            %v = (d1-obj.d_bar)*cos(alp1) + (d2-obj.d_bar)*cos(alp2) ...
            %    + obj.gam*(d1-d2)*(cos(alp1)-cos(alp2));
            v = obj.norm_v( v/2 );
        end
        
        function [w] = compute_w(obj, alp1, alp2)
            % This function computes the control w
            w = obj.norm_w( (alp1+alp2-2*pi)/2 );
        end
        
        function [xdot] = compute_dynamics(obj, alp1, alp2, v, w)
            % This function computes dot{d1}, dot{d2}, dot{alp1}, dot{alp2}
            xdot = zeros(4, 1);
            xdot(1) = -v * cos(alp1);
            xdot(2) = -v * cos(alp2);
            xdot(3) = -w; 
            xdot(4) = -w;
        end
        
        function [J] = compute_J(obj, d1, d2, alp1, alp2)
            % This function computes J
            J = norm(d1-obj.d_bar)^2 + obj.gam*norm(d2-obj.d_bar)^2 ...
                + norm(alp1-obj.alp1_bar)^2 + norm(alp2-obj.alp2_bar)^2;% ...
            %    + obj.gam*norm(d1-d2)^2;
        end
        
        function [Jdot] = compute_Jdot(obj, d1, d2, alp1, alp2, v, w)
            % This function computes dot{j}
            [xdot] = obj.compute_dynamics(alp1, alp2, v, w);
            
            Jdot = 2*(d1-obj.d_bar)*xdot(1) + obj.gam*2*(d2-obj.d_bar)*xdot(2) ...
                + 2*(alp1-obj.alp1_bar)*xdot(3) + 2*(alp2-obj.alp2_bar)*xdot(4); %...
                %+ 2*obj.gam*(d1-d2)*(xdot(1)-xdot(2));
        end
        
        
        function v_norm = norm_v(obj, v)
            % This function normalize the linear velocity
            %v = abs(v);     % only positive v is allowed
            
            if abs(v) > obj.v_max
                v_norm = v / obj.v_max;
            else
                v_norm = v;
            end
        end
        
        function w_norm = norm_w(obj, w)
            % This function normalize the angular velocity
            if abs(w) > obj.w_max
                w_norm = w / abs(w) * obj.w_max;
            else
                w_norm = w;
            end
        end
        
        function [xp] = compute_robot_pos(obj, xtraj)
            % This function computes the robot position given the xtraj 
            traj_length = size(xtraj, 2);
            xp = zeros(2, traj_length);
            xp(:, 1) = obj.pA0;
            
            for i = 2: traj_length
                d1 = xtraj(1, i);
                alp1 = xtraj(3, i);
                theta = xtraj(5, i);
                xp(:, i) = obj.PB - [d1*cos(theta+alp1); d1*sin(theta+alp1)];
            
                d2 = xtraj(2, i);
                alp2 = xtraj(4, i);
                %xp(:, i) = obj.PC - [d2*cos(theta+alp2); d2*sin(theta+alp2)];
            end
        end
        
        function plot_traj(obj, xtraj)
            % This function plots the trajectory of the robot
            h = figure;
            
            traj_length = size(xtraj, 2);
            xp = obj.compute_robot_pos(xtraj);
            for i = 1: traj_length
                clf(h);
%                [xtraj(1,i), xtraj(2,i), rad2deg(xtraj(3,i)), rad2deg(xtraj(4,i)), rad2deg(xtraj(5,i))]
                
                % plot B and C
                obj.plot_rectangle(obj.PB);
                hold on 
                obj.plot_rectangle(obj.PC);
                axis equal
                
                % plot A and the trajectory points
                x = xtraj(1:2, i);
                alp1 = xtraj(3, i);
                theta = xtraj(5, i);
                
                pA = obj.PB - [x(1)*cos(theta+alp1); x(1)*sin(theta+alp1)];
                obj.plot_rectangle(pA);
                obj.plot_direction_bar(pA, theta);
                for j = 1: i
                    plot(xp(1, j), xp(2, j), 'rx', 'MarkerSize', 10);
%                    plot(xtraj(1, j), xtraj(2, j), 'rx', 'MarkerSize', 10);
                end 
                pause(0.01)
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
        
        function plot_direction_bar(obj, center, theta)
            % This function plots the directional bar for the robot
            % center is the starting point of the bar
            l = 0.15;
            end_pt = l *[ cos(theta); sin(theta)] + center;
            line([center(1) end_pt(1)], [center(2) end_pt(2)], ...
                'Color', 'k', 'LineWidth', 2);
        end
        
    end
end

