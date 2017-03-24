%% Coverage path planning algorithm (CPP) on grid map - Iterative structured orientation coverage (ISOC)
%
% Requirements: - 2015b or newer MATLAB
%               - Parallel Computing Toolbox
%               - Image Processing Toolbox
%               - Robotics System Toolbox
% Copyright (c) Erno Horvath (www.sze.hu/~herno | https://www.linkedin.com/in/herno | github.com/horverno)
%

%% load settings from file
if(~exist('myColorMap','var'))
    load('Settings.mat');
end

%% Start parallel pool if not already started
if isempty(gcp('nocreate')) % gcp - get current paralell pool
    parpool;
end

%% Choose map
mapDBase = dir('Maps\*.mat');
[chosenMap,~] = listdlg('PromptString','Select a map:','SelectionMode','single', 'ListString', {mapDBase.name}, 'ListSize', [500 200]);
if ~isempty(chosenMap)
    load(['Maps\', lower(mapDBase(chosenMap).name)]);
else
    disp('No map is chosen');
    return;
end

%% Settings
close all
randCoverItemSize = 150;
mapUnderTest = ~padarray(~map, [10 10]); % add border to the map
debug = 0;
resultPathSize = 0;
debugMainLines = [];
lineDistance = 17; % the distance of the main lines from each other in pixels
bestLineAngle = rad2deg(45.00+90);

%% Display map
fig1 = figure('Name', 'Map');
figure(fig1);
image(uint8(~mapUnderTest)); % + uint8(bwmorph(~mapUnderTest,'skel',Inf)) (bwmorph(~mapUnderTest, 'skel', Inf))
h = zoom; % zoom by default
set(h, 'Motion', 'both', 'Enable', 'on'); % zoom by default
colormap(myColorMap);
colorbar();
set(fig1,'Color',[1 1 1], 'units', 'pixels', 'outerposition', [0 0 800 800])
monitorProperies= get(0,'MonitorPositions');
if size(monitorProperies, 1) == 2
    set(fig1, 'Position',[2000 100 1000 900])
end
movegui(fig1,'center')
tic

%% Find the ISOC main lines
disp('Erode the image with the structuring element, morphologically close image');
% Erode the image with the structuring element, morphologically close image
mapUnderTest2 = ~imerode(~mapUnderTest, strel('square', 20));

% numberOfMainLines is the number of main lines, the smaller the better
[isocMainLineCoordStart, isocMainLineCoordEnd, ~ ] = IsocFindMainLines(mapUnderTest2, bestLineAngle, lineDistance);
numberOfMainLines = size(isocMainLineCoordStart, 1); % start value for numberOfMainLines
for lineAngle = -pi/2:0.4:pi/2 % angle resolution
    [isocMainLineCoordStart, isocMainLineCoordEnd, ~ ] = IsocFindMainLines(mapUnderTest2, lineAngle, lineDistance);
    if debug
        debugMainLines = [debugMainLines; lineAngle, size(isocMainLineCoordStart, 1)];
    end
    if numberOfMainLines > size(isocMainLineCoordStart, 1)
        numberOfMainLines = size(isocMainLineCoordStart, 1);
        bestLineAngle = lineAngle;
    end
end
if debug
    fig2 = figure('Name', 'Debug');
    %bar(debugMainLines(:,1), debugMainLines(:,2));
    disp(strcat('Best main line angle is: ', num2str(bestLineAngle)));
    disp(strcat('Number of main lines: ', num2str(numberOfMainLines)));
end
figure(fig1);
hold on
[isocMainLineCoordStart, isocMainLineCoordEnd, lineGraph ] = IsocFindMainLines(mapUnderTest2, bestLineAngle, lineDistance);
for i = 1:size(isocMainLineCoordStart,1)
    % pause(0.5)
    plot([isocMainLineCoordStart(i,1), isocMainLineCoordEnd(i,1)], [isocMainLineCoordStart(i,2), isocMainLineCoordEnd(i,2)], '*-', 'LineWidth', 2);
end
% lineGraphSource = isocMainLineCoordStart(:,4)';
% lineGraphTarget = ones(size(lineGraphSource)); % todo
% lineGraph = graph(lineGraphSource, lineGraphTarget);
xCoordOfLines = ((isocMainLineCoordStart(:,1) + isocMainLineCoordEnd(:,1)) / 2)';
yCoordOfLines = ((isocMainLineCoordStart(:,2) + isocMainLineCoordEnd(:,2)) / 2)';
%fig3 = figure('Name', 'Graph');
figure(fig1);
plot(lineGraph, 'XData', xCoordOfLines, 'YData', yCoordOfLines, 'MarkerSize', 10, 'LineWidth', 8, 'EdgeColor', 'white');
minSpanTree = minspantree(lineGraph);
plot(minSpanTree, 'XData', xCoordOfLines, 'YData', yCoordOfLines, 'MarkerSize', 16, 'LineWidth', 10, 'EdgeColor', 'red');
for i = 1:size(isocMainLineCoordStart,1)
    text((isocMainLineCoordStart(i,1) + isocMainLineCoordEnd(i,1)) / 2, (isocMainLineCoordStart(i,2) + isocMainLineCoordEnd(i,2)) / 2, num2str(isocMainLineCoordStart(i,4)), 'Color', 'w', 'FontSize', 15);
end
resultTime = toc;


%% Specifiy line visiting order (while visiting every line in the lineGraph)
disp('Specifiy line visiting order (while visiting every line in the lineGraph)');
[lineOrder] = IsocLineOrder(lineGraph, xCoordOfLines, yCoordOfLines);
if debug
    fig3 = figure('Name', 'Graph');
    figure(fig3)
    fig3 = plot(lineGraph, 'XData', xCoordOfLines, 'YData', yCoordOfLines, 'MarkerSize', 10, 'LineWidth', 8, 'EdgeColor', 'r', 'NodeColor','r');
    for i = 1:size(lineOrder, 2)
        % pause(0.5)
        highlight(fig3, lineOrder(i), 'NodeColor','g','EdgeColor','g')
    end
end

if max(conncomp(lineGraph)) ~= 1
    disp('Error: the graph is not connected!');
    waitfor(msgbox('Error: the graph is not connected!'));
    return;
end
if debug
    fig4 = figure('Name', 'Line order result');
    figure(fig4)
    if size(monitorProperies, 1) == 2
        set(fig4, 'Position',[2000 100 1000 900])
    end
    colormap(myColorMap);
end
isocPath = [];
for i = 1:size(lineOrder, 2)
    if mod(i, 2) == 0
        isocPath = [isocMainLineCoordStart(lineOrder(i), 2), isocMainLineCoordStart(lineOrder(i), 1); isocPath];
        isocPath = [isocMainLineCoordEnd(lineOrder(i), 2), isocMainLineCoordEnd(lineOrder(i), 1); isocPath];
    else
        isocPath = [isocMainLineCoordEnd(lineOrder(i), 2), isocMainLineCoordEnd(lineOrder(i), 1); isocPath];
        isocPath = [isocMainLineCoordStart(lineOrder(i), 2), isocMainLineCoordStart(lineOrder(i), 1); isocPath];
    end
end
if debug
    hold on
    image(uint8(mapUnderTest));
    for i = 1:size(isocPath, 1) - 1
        hold on
        plot([isocPath(i, 2), isocPath(i+1, 2)], [isocPath(i, 1), isocPath(i + 1, 1)], '*-', 'LineWidth', 4)
    end
end

%% improfile Pixel-value cross-sections along line segments
fig5 = figure('Name', 'Final result');
figure(fig5)
if size(monitorProperies, 1) == 2
    set(fig5, 'Position',[2000 100 1000 900])
end
colormap(myColorMap);
image(uint8(mapUnderTest));
finalPath = [ , ]; 
for i = 1:size(isocPath, 1) - 1
    hold on
    if all(improfile(~mapUnderTest, [isocPath(i, 2), isocPath(i+1, 2)], [isocPath(i, 1), isocPath(i + 1, 1)]))
        plot([isocPath(i, 2), isocPath(i + 1, 2)], [isocPath(i, 1), isocPath(i + 1, 1)], '-', 'LineWidth', 2)
        finalPath = [finalPath; isocPath(i, 2), isocPath(i, 1)];
    else
        %plot([isocPath(i, 2), isocPath(i+1, 2)], [isocPath(i, 1), isocPath(i + 1, 1)], '*', 'LineWidth', 2)
        probRoadmapPath = IsocProbRoadmap((flipud(mapUnderTest)),  fliplr(isocPath(i, :)), fliplr(isocPath(i + 1, :)));
        plot(probRoadmapPath(:,1), probRoadmapPath(:,2),'-', 'LineWidth', 2);
        finalPath = [finalPath; probRoadmapPath(:,1), probRoadmapPath(:,2)];
    end
end
finalPath = [finalPath; isocPath(end, 2), isocPath(end, 1)];
hold on

%plot(isocPath(:, 2), isocPath(:, 1), '*-', 'LineWidth', 4); %

%% Display the final result
fig6 = figure('Name', 'Final path');
figure(fig6)
if size(monitorProperies, 1) == 2
    set(fig6, 'Position',[1950 100 1000 900])
end
colormap(myColorMap);
hold on
image(uint8(mapUnderTest));
plot(finalPath(:,1), finalPath(:,2), 'o-w', 'LineWidth', 2);
pathLength = 0;
for i = 1:size(finalPath,1) - 1
    pathLength = pathLength + pdist([finalPath(i, 1), finalPath(i, 2); finalPath(i + 1, 1), finalPath(i + 1, 2)], 'euclidean');
end
fprintf('The length of the path is %0.2f\nTime elapsed %0.2f s\n Best line angle: %.2f° %.4frad ', pathLength, resultTime, rad2deg(bestLineAngle), bestLineAngle);

%% Write the results into file
if ~isempty(chosenMap)
    resultFile = fopen('Restult.txt', 'a+');
    fprintf(resultFile, '%s;%s;%.2f;%.2f\r\n', 'Isoc', lower(mapDBase(chosenMap).name), resultTime, pathLength);
    fclose(resultFile);
end