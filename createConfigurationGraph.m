function graph = ...
    createConfigurationGraph(qSet,k,radius,stepInPlane)

% Create a configuration graph with a set of free configurations of disks
% in the plane.
% graph = createConfigurationGraph(qSet,k,radius,stepInPlane,costFunction)
%
% Local planner used: a straight line segment between two configurations.
%
% Inputs:
%   - qSet: set of collision free configurations of the disks. Line index
%           is the configuration number. The columns (2n for n disks) are
%           the coordinates of the disk centers in the plane.
%   - k: number of nearest neighbors to use when building the graph.
%   - radius: radii of the disks.
%   - stepInPlane: step for testing whether a segment is collision free.
%                  Not defined in configuration space but in 2D plane.
%   - costFunction: handler to the function used to define the cost
%                   of a segment.
% Outputs:
%   - graph, the graph represented as an adjacency matrix. graph(i,j)=0
%            means no arc from node i to node j. graph(i,j)=1 means there
%            is an arc from i to j.
%
% Author: Gaetan Garcia - Ecole Centrale de Nantes - March 2016.

graph = sparse( size(qSet,1) ) ;

% Progress bars seem to take up quite a bit of resources, so they were
% replaced by a low-tech, low-consumption solution...
% wbHandle = waitbar(0,'Generating graph edges...') ;


% ATTENTION: revoir ce programme pour ne pas calculer les collisions 
% deux fois pour chaque segment.
% Doit pouvoir se faire en remplaçant:
%nearest = nearest( (nearest ~= i) ) ;
% par:
% nearest = nearest( (nearest > i) ) ;



for i = 1 : size(qSet,1) 
    % Low tech progress indicator
    if mod(i,100) == 0 
        fprintf('%c','.');
    end
    %waitbar(i/size(qSet,1)) ;
    % Search for k+1 neighbors because configuration i will be in the list.
    nearest = knnsearch(qSet,qSet(i,:),'K',k+1,'NSMethod','exhaustive',...
                        'Distance','euclidean') ;
    % Eliminate the node itself.
    nearest = nearest( (nearest ~= i) ) ;
    for j = 1 : length(nearest) 
        if collisionFreeSegment( qSet(i,:),qSet(nearest(j),:),stepInPlane,radius )
            graph(i,nearest(j)) = costFunction( qSet(i,:) , qSet(nearest(j),:) ) ;
            graph(nearest(j),i) = graph(i,nearest(j)) ;
        end
    end
end
disp('Done generating graph!');
%close(wbHandle) ;
return 
end
