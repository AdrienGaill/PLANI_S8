function qFree = generateFreeConfigurations( nbConfig , box , radius )

% Generate collision free configurations of disks in the plane.
% qFree = generateFreeConfigurations( nbConfig , box , radius )
%
% Inputs:
%   - nbConfig, number of collisions free configurations to generate.
%   - box(1:4), defines the bounding box in which the centers of the disks
%               must fit (order: xmin, xmax, ymin, ymax).
%   - radius,   vector of the disk radii. The length of the vector is the
%               number of disks.
% Outputs:
%   - qFree, the array of collision free configurations. The size of qFree
%            after successful execution of the funcion is 
%            nbConfig lines * (2*nb of disks) columns.
% Remarks:
%   - It is up to the user of the function to define inputs which are
%     reasonable (i.e. do not cause the function to search for too long,
%     possibly indefinitely).
%
% Author: Gaetan Garcia - Ecole Centrale de Nantes - March 2016.

configCounter = 0 ;
nbDisks       = length(radius) ;
qFree         = zeros( nbConfig , 2*nbDisks ) ;
boxMin        = zeros(2*nbDisks,1) ;
boxWidth      = boxMin ;
%wbHandle = waitbar(0,'Generating free configurations...') ;
for i = 1 : 2*nbDisks
    if mod(i,2) == 1
        boxMin(i)   = box(1)        ;
        boxWidth(i) = box(2)-box(1) ;
    else
        boxMin(i)   = box(3)        ;
        boxWidth(i) = box(4)-box(3) ;
    end
end
while configCounter < nbConfig
    q = rand(2*nbDisks,1).*boxWidth + boxMin ;
    if ~isCollision( q , radius )
        configCounter = configCounter + 1 ;
        qFree(configCounter,:) = q ;
        if mod(configCounter,1000) == 0
            %waitbar(configCounter/nbConfig)
            fprintf('%c','.');
        end
    end
end
%close(wbHandle) ;
disp('Done generating configurations.');
save FreeConfigs qFree nbConfig box radius ;
end