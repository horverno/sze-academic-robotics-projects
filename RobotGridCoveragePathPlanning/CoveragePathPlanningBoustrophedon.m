%% Coverage path planning algorithm on grid map - Boustrophedon
%
% Requirements: - 2015b or newer MATLAB
%               - Image processing toolbox
% Copyright (c) Erno Horvath (www.sze.hu/~herno | https://www.linkedin.com/in/herno | github.com/horverno)
%

%% Maps loaded from file
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

%%
tic
cellGraphSource = [];
cellGraphTarget = [];
%hold on
parfor i = 1:size(subPolygons,1) %paralell for loop
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
toc

%size(xCoordOfSubPolygons,2)
% cellGraph from source and target
cellGraph = graph(cellGraphSource, cellGraphTarget);
plot(cellGraph, 'XData', xCoordOfSubPolygons, 'YData', yCoordOfSubPolygons, 'MarkerSize', 12, 'LineWidth', 4)

% axis square
% s = regionprops(mapUnderTest, 'centroid');
% centroids = cat(1, s.Centroid);



% todo: building the graph and the motion

%%
% measurements = regionprops(mapUnderTest, 'orientation');
% angle = measurements(1).Orientation;
% message = sprintf('The angle is %.3f degrees\n', angle);
% uiwait(msgbox(message));
% hold off
% contour = bwtraceboundary(logical(mapUnderTest),[163 37],'W',8,Inf,'counterclockwise');
% hold on;
% plot(contour(:,2),contour(:,1),'g','LineWidth',2);
% BW3 = bwmorph(~mapUnderTest,'skel',Inf);
% figure
% imshow(BW3)

%% Display debug info
% fig2 = figure('Name', 'Covered area', 'Position',[20,500,450,285]);
% set(0, 'currentfigure', fig2);

%% Boustrophedon algorithm