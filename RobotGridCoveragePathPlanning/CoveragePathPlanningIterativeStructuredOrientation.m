%% Coverage path planning algorithm (CPP) on grid map - Iterative structured orientation coverage (ISOC)
%
% Requirements: - 2015b or newer MATLAB
%               - Parallel Computing Toolbox
%               - Image Processing Toolbox
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
debug = true;
resultPathSize = 0;
debugMainLines = [];
lineDistance = 50; % the distance of the main lines from each other in pixels

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
% numberOfMainLines is the number of main lines, the smaller the better
[isocMainLineCoordStart, isocMainLineCoordEnd] = IsocFindMainLines(mapUnderTest, pi / 5, lineDistance);
numberOfMainLines = size(isocMainLineCoordStart, 1); % start value for numberOfMainLines
for lineAngle = -pi/2:0.1:pi/2
    [isocMainLineCoordStart, isocMainLineCoordEnd] = IsocFindMainLines(mapUnderTest, lineAngle, lineDistance);
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
    bar(debugMainLines(:,1), debugMainLines(:,2));
    disp(strcat('Best main line angle is: ', num2str(bestLineAngle)));
    disp(strcat('Number of main lines: ', num2str(numberOfMainLines)));
end
figure(fig1);
hold on
[isocMainLineCoordStart, isocMainLineCoordEnd] = IsocFindMainLines(mapUnderTest, bestLineAngle, lineDistance);
for i = 1:size(isocMainLineCoordStart,1)
    plot([isocMainLineCoordStart(i,1), isocMainLineCoordEnd(i,1)], [isocMainLineCoordStart(i,2), isocMainLineCoordEnd(i,2)], '*-', 'LineWidth', 2);
    text((isocMainLineCoordStart(i,1) + isocMainLineCoordEnd(i,1)) / 2, (isocMainLineCoordStart(i,2) + isocMainLineCoordEnd(i,2)) / 2, num2str(isocMainLineCoordStart(i,4)), 'Color', 'w', 'FontSize', 15);
end
lineGraphSource = isocMainLineCoordStart(:,4)';
lineGraphTarget = ones(size(lineGraphSource)); % todo
lineGraph = graph(lineGraphSource, lineGraphTarget);
xCoordOfLines = ((isocMainLineCoordStart(:,1) + isocMainLineCoordEnd(:,1)) / 2)';
yCoordOfLines = ((isocMainLineCoordStart(:,2) + isocMainLineCoordEnd(:,2)) / 2)';
%fig3 = figure('Name', 'Graph');
figure(fig1);
plot(lineGraph, 'XData', xCoordOfLines, 'YData', yCoordOfLines, 'MarkerSize', 12, 'LineWidth', 4);

resultTime = toc;

%% Write the results into file
% if ~isempty(chosenMap)
%    resultFile = fopen('Restult.txt', 'a+');
%    fprintf(resultFile, '%s;%s;%.2f;%.2f\r\n', 'ISOC', lower(d(chosenMap).name), resultTime, resultPathSize);
%    fclose(resultFile);
% end