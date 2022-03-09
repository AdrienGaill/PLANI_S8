function qFree = generateFreeConfigurations( nbConfig , box)

% Generate collision free configurations of disks in the plane.
% qFree = generateFreeConfigurations( nbConfig , box , radius )
%
% Inputs:
%   - nbConfig, number of collisions free configurations to generate.
%   - box(1:4), defines the bounding box in which the centers of the disks
%               must fit (order: xmin, xmax, ymin, ymax).

% Outputs:
%   - qFree, the array of collision free configurations. The size of qFree
%            after successful execution of the funcion is 
%            nbConfig lines * (2*nb of disks) columns. ??? plutôt 8 je pense
% Remarks:
%   - It is up to the user of the function to define inputs which are
%     reasonable (i.e. do not cause the function to search for too long,
%     possibly indefinitely).
%
% Author: Gaetan Garcia - Ecole Centrale de Nantes - March 2016.

configCounter = 0 ;
qFree         = zeros( nbConfig , 8 ) ;
%boxMin        = zeros(4,1) ;
%boxWidth      = boxMin ;
%wbHandle = waitbar(0,'Generating free configurations...') ;
%for i = 1 : 4
 %   if mod(i,2) == 1
     %   boxMin(i)   = box(1)        ;
    %    boxWidth(i) = box(2)-box(1) ;
   % else
  %      boxMin(i)   = box(3)        ;
 %       boxWidth(i) = box(4)-box(3) ;
%    end
%end

boxMin = [box(1); box(2); box(1); box(2)];
boxWidth = [box(2)-box(1); box(4)-box(3); box(2)-box(1); box(4)-box(3)];
angleMin = [pi; pi; pi; pi];
angleWidth = 2*angleMin;

while configCounter < nbConfig
    q1 = rand(4,1).*boxWidth + boxMin ;
    q2 = rand(4,1).*angleWidth - angleMin;
    q = [q1(1:2); q2(1:2); q1(3:4), q2(3:4)];
    R1 = segmentsFromConfig(q, 1);
    R2 = segmentsFromConfig(q, 2);


    if (~isCollision( R1, R2)) && (~isCollision( R1, obstacles)) && (~isCollision( R2, obstacles))
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
save FreeConfigs qFree nbConfig box ;
end