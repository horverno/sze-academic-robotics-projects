%% Coverage path planning (CPP) algorithm on grid map - Boustrophedon coverage
%
% Requirements: - 2015b or newer MATLAB
%               - Image Processing Toolbox
%               - Parallel Computing Toolbox
% Copyright (c) Erno Horvath (www.sze.hu/~herno | https://www.linkedin.com/in/herno | github.com/horverno)
%

%% load settings from file
if(~exist('myColorMap','var'))
    load('Settings.mat');
end

%% Choose map
d = dir('Map*.mat');
[chosenMap,~] = listdlg('PromptString','Select a map:','SelectionMode','single', 'ListString',{d.name});
if ~isempty(chosenMap)
    load(lower(d(chosenMap).name));
else
    disp('No map is chosen');
    return;
end

%% Settings
close all
randCoverItemSize = 150;
mapUnderTest = ~padarray(~map, [10 10]); % add border to the map
debug = false;
resultPathSize = 0;

%% Display map
fig1 = figure('Name', 'Map');
figure(fig1);
image(uint8(~mapUnderTest)); % + uint8(bwmorph(~mapUnderTest,'skel',Inf))
h = zoom; % zoom by default
set(h,'Motion','both','Enable','on'); % zoom by default
colormap(myColorMap);
colorbar();
set(fig1,'Color',[1 1 1], 'units','pixels','outerposition',[0 0 800 800])
movegui(fig1,'center')


%% Create blobs to find critical points
[blobs, ~, blobNumber, adjacencyMat] = bwboundaries(~mapUnderTest);
% Test: visulalize blobs
hold on
% Boundary is the parent of a hole if the k-th column
% of the adjacency matrix A contains a non-zero element
% there shold be only 1 parent, because the map is coherent
if (nnz(adjacencyMat(:,1)) > 0)
    boundary = blobs{1};
    plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 4);
    % Loop through the children of boundary k
    for i = find(adjacencyMat(:,1))'
        if size(blobs{i},1) > 30
            boundary = blobs{i};
            if debug
                plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 4);
                plot(min(boundary(:,2)), max(boundary(:,1)), '*', 'LineWidth', 10);
                plot(min(boundary(:,2)), min(boundary(:,1)), '*', 'LineWidth', 10);
            end
            mapUnderTest(max(boundary(:,1)), :) = 1;
            mapUnderTest(max(boundary(:,1)) - 1, :) = 1;            
            mapUnderTest(min(boundary(:,1)), :) = 1;
            mapUnderTest(min(boundary(:,1)) + 1, :) = 1;
        end
    end
    disp('Critical displayed, next step: decomposing map into sub-poygons.');
    if debug
        waitfor(msgbox('Critical displayed, next step: decomposing map into sub-poygons.'));
    end
end
image(uint8(~mapUnderTest));

%% Create cells to decompose the map into sub-poygons
[cells, ~, blobNumber, adjacencyMat] = bwboundaries(mapUnderTest);
% Test: visulalize blobs
xCoordOfSubPolygons = []; 
yCoordOfSubPolygons = [];
subPolygons = [];
j = 1;
if (nnz(adjacencyMat(:,1)) > 0)
    hold on
    boundary = cells{1};
    % Loop through the children of boundary k
    for i = find(adjacencyMat(:,1))'
        if size(cells{i},1) > 30
            boundary = cells{i};
            subPolygons{j,1} = cells{i};
            j = j + 1;
            %if debug
                fill(boundary(:,2), boundary(:,1), myColorMap(mod(j, size(myColorMap, 1)) + 1, :), 'FaceAlpha', 0.8, 'LineWidth', 0.01);
            %end
            xCoordOfSubPolygons = [xCoordOfSubPolygons, ((min(boundary(:,2)) + max(boundary(:,2))) / 2)]; 
            yCoordOfSubPolygons = [yCoordOfSubPolygons, ((min(boundary(:,1)) + max(boundary(:,1))) / 2)];
        end
    end
end

figure(fig1);
hold on
disp('Sub-poygon decomposed map displayed, next step display connectivity graph.');
if debug
    waitfor(msgbox('Sub-poygon decomposed map displayed, next step display connectivity graph.'));
end
tic

%% Determine connectivity graph (cellGraph)
cellGraphSource = [];
cellGraphTarget = [];
%hold on
parfor i = 1:size(subPolygons,1) % paralell for loop
    for j = i:size(subPolygons,1)
        if i ~= j
            tmpImage = logical(zeros((size(mapUnderTest))));
            for k = 1:size(subPolygons{i}, 1)
                tmpImage(subPolygons{i}(k,1), subPolygons{i}(k,2)) = true; 
            end
            for k = 1:size(subPolygons{j}, 1)
                tmpImage(subPolygons{j}(k,1), subPolygons{j}(k,2)) = true; 
            end
            tmpImage = imfill(tmpImage,'holes');
            se = strel('line',10,40);
            tmpImage = imdilate(tmpImage, se);
            [~,~,numOfBlobs,~] = bwboundaries(tmpImage);
            if numOfBlobs == 1
                isConnected = true;
            elseif numOfBlobs == 2
                isConnected = false;
            else
                isConnected = false;
                waitfor(msgbox('Blob number is not 1 either 2! Unable to determine the connection between cells!'));
            end
            if isConnected
                cellGraphSource = [cellGraphSource, i];
                cellGraphTarget = [cellGraphTarget, j];
            end   
        end
    end
    disp(strcat('Number of iteration is:  ', num2str(i), '/', num2str(size(subPolygons,1)) ));
 end

% cellGraph from source and target
cellGraph = graph(cellGraphSource, cellGraphTarget);

%% Determining the motion according the connectivity graph (cellGraph)
% Order nodes according x 
[yCoordOfSubPolygons, index] = sort(yCoordOfSubPolygons);
xCoordOfSubPolygons = xCoordOfSubPolygons(index);
cellGraph = reordernodes(cellGraph,index);
p = plot(cellGraph, 'XData', xCoordOfSubPolygons, 'YData', yCoordOfSubPolygons, 'MarkerSize', 12, 'LineWidth', 4);

% Build the node list
nodeList = java.util.ArrayList;
nodeList.clear();
for i = 1:cellGraph.numnodes
    nodeList.add(num2str(index(i)));
end

nextNode = 1;
prevNode = 1;
i = 0;
nodeCount = 1;
greedyOrder = [1];
% Graph greedy algorithm - choose the obvious (if only 1 neghbour) or bottom-up
% Loop until maximum 50 iteration or until the list is empty
while ~nodeList.isEmpty && i < 200
    if nodeList.contains(num2str(nextNode))
        nodeList.remove(num2str(nextNode));
        path = shortestpath(cellGraph, prevNode, nextNode);
        for l = 1:size(path, 2)
            if nodeList.contains(num2str(path(l)))
                nodeList.remove(num2str(path(l)));
            end
        end
        highlight(p, path,'NodeColor','r', 'EdgeColor','r')
        greedyOrder = [greedyOrder path(2:end)];
    else
        disp('There is no such node.');
    end
    hold on
    %highlight(p,nextNode,'NodeColor','r', 'EdgeColor','r')
    prevNode = nextNode;
    i = i + 1;
    nodeNeighbor = [];
    tmp = neighbors(cellGraph, nextNode);
    for j = 1:size(tmp, 1)
       if nodeList.contains(num2str(tmp(j)))
           nodeNeighbor = [nodeNeighbor tmp(j)];
       end
    end
    % If node has 1 neighbor than choose it
    if size(nodeNeighbor) == 1
        nextNode = nodeNeighbor;
        %disp('If node has 1 neighbor than choose it');
    % Else choose another close node
    else
        while ~nodeList.contains(num2str(nodeCount)) && i < 200
            nodeCount = nodeCount + 1;
            i = i + 1;
        end
        nextNode = nodeCount;
    end
end
resultTime = toc;
disp(greedyOrder);

%% Generate the digraph object (directed graph) which is basically the boustrophedon path
subXY = cell(size(subPolygons));
for i = 1:size(subPolygons,1)
    for j = min(subPolygons{i}(:,1)):max(subPolygons{i}(:,1))
        if mod(j, 17) == 0 % the distances between horizontal lines
            if mod(j, 2) == 0 % boustrophedon path
                subXY{i} = [subXY{i}; j, (min(subPolygons{i}((find(subPolygons{i}(:,1) == j)), 2)) + 8)]; 
                subXY{i} = [subXY{i}; j, (max(subPolygons{i}((find(subPolygons{i}(:,1) == j)), 2)) - 8)]; 
            else
                subXY{i} = [subXY{i}; j, (max(subPolygons{i}((find(subPolygons{i}(:,1) == j)), 2)) - 8)]; 
                subXY{i} = [subXY{i}; j, (min(subPolygons{i}((find(subPolygons{i}(:,1) == j)), 2)) + 8)]; 
            end               
        end
    end
end



figure
subXyAll = [];
for i = greedyOrder
    if ~isempty(subXY{i})
        subXyAll = [subXyAll; subXY{i}];        
    end
end
hold on
plot(subXyAll(:,2), subXyAll(:,1), '*-', 'LineWidth', 4); % plot the connected boustrophedon path

%% Write the results into file
if ~isempty(chosenMap)
    resultFile = fopen('Restult.txt', 'a+');
    fprintf(resultFile, '%s;%s;%.2f;%.2f\r\n', 'Boustrophedon', lower(d(chosenMap).name), resultTime, resultPathSize);
    fclose(resultFile);
end
