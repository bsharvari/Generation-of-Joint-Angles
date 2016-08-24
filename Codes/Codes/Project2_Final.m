% Project 2

clc;
clear all;
close all;

if exist('angles', 'file') == 2
  delete('angles');
end

arm = dlmread('arm');
traj = dlmread('trajectory');
length = arm(2:end,1);
theta = arm(2:end,2);
lambda = arm(1,2);
num_links = arm(1,1);
m = traj(1,1);

e1 = 0.02;
e2 = 1e-7;
delta_x = zeros(1,2);
delta_theta = zeros(num_links,1);

for i = 1 : m + 1
    while(1)
        % Forward Kinematics
        current_position = forward_kinematics (length,theta);
        
        % Computation of error in position
        delta_x(1,1) = traj(i+1,1) - current_position(1,1);
        delta_x(1,2) = traj(i+1,2) - current_position(1,2);
                
        % Computation of Jacobian
        J = jacobian (num_links,length,theta);
        
        % Computation of error in joint angles by Damped Least Squares Method
        dls = J'*inv((J*J' + (lambda^2)*eye(2)));
        delta_theta = dls*delta_x';
                
        % Add delta_theta to the original theta value
        theta(:,1) = theta(:,1) + delta_theta;
  
        if (abs(sum(delta_x)) < e1)
            if (abs(sum(delta_theta)) < e2)
                break;
            end
        end
    end
    final_theta = theta';
    dlmwrite(fullfile('angles'),final_theta,'-append','delimiter','\t');

end
check_angles;
