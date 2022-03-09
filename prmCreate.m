function prmCreate( radius , box , nbConfigs , kNeighbors , subdivRate )

% Create configuration graph for a PRM planner for disks moving in a
% rectangle of the 2D plane.
%
% Inputs: 
%   - radius: vector of diks radii
%   - box: rectangle in which the disk centers are allowed to move.
%   - nbConfigs: number of configurations in the graph.
%   - kNeighbors: number of closest neighbors with which a configuration  
%        of the graph is tested for connection.
%   - subdivRate: the size of the step for collision testing will be
%        max dimension of the box / subdivRate.
% Outputs:
%   The algorithm saves into a file called graphResults.mat :
%   - all the inputs (for subdivRate, in fact the resulting step is saved).
%   - the set of free configurations generated, qSet.
%   - the adjacency graph, graph.

% Discretization step when checking for collisions along a segment: 
step = max( (box(2)-box(1)) , (box(4)-box(3)) ) / subdivRate ;

% Number of neighbors for graph connectivity

tic ;
qSet = generateFreeConfigurations( nbConfigs , box , radius ) ;
toc ;
tic ;
graph = createConfigurationGraph( qSet , kNeighbors , box , radius ) ;
toc ;

disp(['There were ',num2str(nbIsol),' isolated vertices.']) ;

size(qSet)
size(graph)

save graphResults box radius nbConfigs step kNeighbors qSet graph ;