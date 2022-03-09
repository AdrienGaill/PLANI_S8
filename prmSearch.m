% Search a PRM for a path between two randomly generated configurations.

% Step 1: User selects a pre-calculated PRM in which to search.

dataFile = uigetfile('graphs/*.mat','Select data file') ;
eval(['load graphs/' , dataFile]) ; 

disp('------------');
disp('Conditions:');
disp(['Disks: ',num2str(length(radius))]) ;
radius
size(graph)
disp('-----------');

% Step 2: generate random (free) start and goal configurations

start = generateFreeConfigurations( 1 , box , radius ) ;
goal  = generateFreeConfigurations( 1 , box , radius ) ;

% Step 3: try to connect start and goal configurations to existing
% configurations in the PRM. If this fails, there's no point in searching
% so the program is aborted.

[startAdded,qSet,graph] = ...
    addConfiguration( start , qSet , graph , kNeighbors , step , radius ) ; 
[goalAdded,qSet,graph]  = ...
    addConfiguration( goal , qSet , graph , kNeighbors , step , radius ) ; 

if ~startAdded
    
    error('Could not connect start configuration to graph.');
elseif ~goalAdded 
    error('Could not connect goal configuration to graph.');
end

% Step 4: Start and goal are connected to the graph. Search for a path.
% Abort if none.

[rawPath,rawCost] = astar( size(qSet,1)-1 , size(qSet,1) , ...
                     graph , qSet , @hStarMaxDistInPlane ) ;
if isempty(rawPath) 
    error('No path found.');
end

% Step 5: display and draw the raw path obtained.

rawPath
rawCost

stepForPathDisplay = max(box(2)-box(1),box(4)-box(3)) / 50 ;
figure;
drawPath( rawPath , qSet , stepForPathDisplay , radius , box ) ;
title('Raw path.');

% Step 6: apply simple post-processing to the path, for possible
% improvement (see help of postprocessPath.m).

postProcPath = postprocessPath( rawPath , qSet , step , radius ) 
postProcCost = 0.0 ;
for i = 1 : length(postProcPath)-1
    postProcCost = postProcCost + ...
        norm( qSet(postProcPath(i),:)-qSet(postProcPath(i+1),:) ) ; 
end
postProcCost
figure; 
drawPath( postProcPath , qSet , step , radius , box ) ;
title('Postprocessed path.');