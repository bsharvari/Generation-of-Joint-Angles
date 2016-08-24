% Function to write the jacobian

function jcb = jacobian (num_links,length,theta)
    jcb = zeros (2,num_links);
    jcb_full = zeros (5,num_links);
    t(1,1) = theta(1,1);                        
    for i = 2:size(theta,1)
        t(i,1) = t(i-1,1) + theta(i,1);
    end
    for i = 1:num_links
        jcb_full (1,i) = sum(-1*length(i:end,1).*sin(t(i:end,1)));
        jcb_full (2,i) = sum(length(i:end,1).*cos(t(i:end,1)));
        jcb_full (3,i) = 0;
        jcb_full (4,i) = 0;
        jcb_full (5,i) = 1;
    end
    
    jcb (1,:) = jcb_full (1,:);
    jcb (2,:) = jcb_full (2,:);
end