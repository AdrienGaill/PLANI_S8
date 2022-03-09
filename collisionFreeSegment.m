function collisionFree = collisionFreeSegment( q1,q2 , delta , radius )

% Checks whether configuration space segment [q1,q2] is collision free
% or not. The segment is sampled at delta interval. The radii of the 
% disks are stored in radius.
% Note: delta is an interval in the motion plane, not in the 
% n-dimensional configuration space. So the number of samples is determined
% using the distance function maxDiskDistance (longest distance traveled
% by a disk between q1 and q2).

colors = [ [1 0.7 0.7] ; [0.6 1 0.6] ; [0.7 0.7 1] ; [1 0.7 1] ] ;
dimColors = [ [1 0.95 0.95] ; [0.95 1 0.95] ; [0.95 0.95 1] ; [1 0.95 1] ] ;
dimEdges = [ [1 0.8 0.8] ; [0.8 1 0.8] ; [0.8 0.8 1] ; [1 0.8 1] ] ;
lineColors = [ [1 0 0] ; [0 0.8 0] ; [0 0 1] ; [1 0 1] ] ;

longestDistance = maxDiskDistance( q1 , q2 ) ;
nbSteps = ceil( longestDistance / delta ) ;
incrementVector = (q2-q1) / nbSteps ;
q = q1 ;
i = 0 ;
while ~isCollision(q,radius) && (i<=nbSteps)
     drawConfiguration( q , radius , [0 100 0 100] , colors,lineColors) ; % This was for tests
     pause ;
    clf ;
   i = i+1 ;
   q = q1 + i*incrementVector ;
end
collisionFree = ( i == nbSteps+1 ) ;
if ~collisionFree ,
     sound(randn(100, 1), 8192)
end   
return


end