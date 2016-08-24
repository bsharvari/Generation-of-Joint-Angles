% Function to compute the forward kinematics

function current_position = forward_kinematics (length,theta)
    t(1,1) = theta(1,1);
    for i = 2:size(theta,1)
        t(i,1) = t(i-1,1) + theta(i,1);
    end

current_position(1,1) = sum(length(:,1).*cos(t(:,1)));
current_position(1,2) = sum(length(:,1).*sin(t(:,1)));
end
    