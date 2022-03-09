function collision = isCollision( q , radius ) 

% Check if any two disks of the configuration interfere. The number of
% disks is length(radius), so q has 2*length(radius) elements.
% If the distance between disk i and disk j (j>i) is lower than the sum
% of the radii of the disks, then a collision occurs. As soon as one
% (i,j) collision pair is found, stop calculations.
    
    collision = false ;
    for i = 1 : length(radius)-1
        for j = i+1 : length(radius)
            collision = ...
                norm( [q(2*i-1) q(2*i)] - [q(2*j-1) q(2*j)] ) < ...
                radius(i)+radius(j) ;
            if collision
                return ;
            end
        end
    end
end