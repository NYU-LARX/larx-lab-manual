close all 
clearvars

eps = 1e-5; 
PA = [3; 1.2];     % initial position of robot
rb = robot_triangle(PA);

iter = 1;
xtraj = [PA; rb.alp1_0; rb.alp2_0];
utraj = [];
d1_k = norm(PA-rb.PB);
d2_k = norm(PA-rb.PC);
alp1_k = rb.alp1_0;
alp2_k = rb.alp2_0;
while 1
    % compute controls
    v_k = rb.compute_v(d1_k, d2_k, alp1_k, alp2_k);
    w_k = rb.compute_w(alp1_k, alp2_k);
    utraj(:,iter) = [v_k; w_k];
    
    % simulate dynamics 
    xdot = rb.compute_dynamics(alp1_k, alp2_k, v_k, w_k);
    xtraj(:, iter+1) = xtraj(:, iter) + xdot*rb.dt;
    
    % update variable
    d1_k = xtraj(1, iter+1);
    d2_k = xtraj(2, iter+1);
    alp1_k = xtraj(3, iter+1);
    alp2_k = xtraj(4, iter+1);
    
    % stopping condition
    if abs(rb.compute_Jdot(d1_k, d2_k, alp1_k, alp2_k, v_k, w_k)) <= eps
        break
    end
    
    iter = iter + 1;
end

rb.plot_traj(xtraj);
