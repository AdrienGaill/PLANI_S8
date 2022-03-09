% Add configuration q to a graph of configurations.
% function [wasAdded,qSet,graph] = addConfiguration( q , qSet , graph , ...
%                                     kNeighbors , delta , radius ) 
% 
% Inputs:
% - q: Configuration to add to the graph.
% - qSet: Set of all configurations currently in the graph.
% - graph: adjacency matrix describing the graph (sparse matrix).
% - kNeighbors: number of neighbors to try to connect to.
% - delta: step in configuration space for local planner.
% - radius: radii of the disks.
% 
% Output:
% - wasAdded: boolean, true if the configuration was connected to at 
%             least one other node of the graph.
% - qSet, graph: Modified graph after addition.
%
function [wasAdded,qSet,graph] = addConfiguration( q , qSet , graph , ...
                                     kNeighbors , delta , radius ) 

nearest = knnsearch(qSet,q,'K',kNeighbors,'NSMethod','exhaustive') ;
nbNodes = size(graph,1) ;
wasAdded = false ;  % Until proved otherwise.
for i = 1 : kNeighbors
    if collisionFreeSegment( q , qSet(nearest(i),:) , delta , radius )
        graph(nbNodes+1,nearest(i)) = norm( q-qSet(nearest(i),:) ) ;
        graph(nearest(i),nbNodes+1) = graph(nbNodes+1,nearest(i)) ;
        qSet(nbNodes+1,:) = q ;
        wasAdded = true ;
    end
end