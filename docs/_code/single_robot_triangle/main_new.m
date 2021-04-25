close all 
clearvars

eps = 1e-5; 
PA = [3; 1.5];     % initial position of robot
rb = robot_triangle_new(PA);

iter = 1;
iter_max = 1e4;
xtraj = [norm(PA-rb.PB); norm(PA-rb.PC); rb.alp1_0; rb.alp2_0; rb.theta_0; rb.theta_0];
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
    xtraj_new = zeros(5, 1);
    xtraj_new(1: 4) = xtraj(1:4, iter) + xdot*rb.dt;
    % projection
    xtraj_new(3) = rb.proj_alp(xtraj_new(3));
    xtraj_new(4) = rb.proj_alp(xtraj_new(4));
    % theta
    xtraj_new(5) = rb.alp1_0 - xtraj_new(3) + rb.theta_0;
    xtraj_new(6) = rb.alp2_0 - xtraj_new(4) + rb.theta_0;
    xtraj(:, iter+1) = xtraj_new;
    
    % update variable
    d1_k = xtraj(1, iter+1);
    d2_k = xtraj(2, iter+1);
    alp1_k = xtraj(3, iter+1);
    alp2_k = xtraj(4, iter+1);
    
    %rb.compute_Jdot(d1_k, d2_k, alp1_k, alp2_k, v_k, w_k)
    % stopping condition
    if abs(rb.compute_Jdot(d1_k, d2_k, alp1_k, alp2_k, v_k, w_k)) <= eps || ...
        iter >= iter_max
        rb.compute_J(d1_k, d2_k, alp1_k, alp2_k)
        break
    end
    
    iter = iter + 1;
end

%rb.plot_traj(xtraj);
