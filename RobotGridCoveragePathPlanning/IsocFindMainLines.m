%% Find main lines on ISOC algorithm
%  Coverage path planning algorithm (CPP) on grid map - Iterative structured orientation coverage (ISOC)
%
% Requirements: - 2015b or newer MATLAB
%               - Parallel Computing Toolbox
%               - Image Processing Toolbox
% Copyright (c) Erno Horvath (www.sze.hu/~herno | https://www.linkedin.com/in/herno | github.com/horverno)
%


%%


function [ isocMainLineCoordStart, isocMainLineCoordEnd, lineGraph ] = IsocFindMainLines(mapUnderTest, lineAngle, lineDistance)

% lineAngle = -1;
% lineDistance = 40;
%% Creation of the coordinates

mapCenter = size(mapUnderTest)/2;
mapWidth = size(mapUnderTest, 1);
mapHeight = size(mapUnderTest, 2);
bigSquare = sqrt(mapWidth^2 + mapHeight^2);
lineCoordStart = (zeros(uint16(bigSquare / lineDistance + 1), 2));
lineCoordEnd = (zeros(uint16(bigSquare / lineDistance + 1), 2));
for i = 1:(bigSquare / lineDistance)
    x1 = - bigSquare / 2;
    x2 = + bigSquare / 2;
    y1 = - bigSquare / 2 + i * lineDistance;
    y2 = - bigSquare / 2 + i * lineDistance;
    lineCoordStart(i,:) = [x1, y1];
    lineCoordEnd(i,:) = [x2, y2];
end

% % Debug

% image(uint8(~mapUnderTest)); % + uint8(bwmorph(~mapUnderTest,'skel',Inf))
% h = zoom; % zoom by default
% set(h,'Motion','both','Enable','on'); % zoom by default
% get(gcf);
% set(gcf, 'Position',[2000 100 1000 900]);
% colormap(myColorMap);
% colorbar();
% set(gcf, 'Position',[2000 100 1000 900])
% hold on

%for lineAngle = -pi/2:0.2:pi/2

%% Rotation of the main coordinates 
lineCoordStart = [cos(lineAngle),-sin(lineAngle); sin(lineAngle),cos(lineAngle)] * lineCoordStart';
lineCoordStart = lineCoordStart';
lineCoordStart = [lineCoordStart(:,1) + mapCenter(2), lineCoordStart(:,2) + mapCenter(1)];
lineCoordEnd = [cos(lineAngle),-sin(lineAngle); sin(lineAngle),cos(lineAngle)] * lineCoordEnd';
lineCoordEnd = lineCoordEnd';
lineCoordEnd = [lineCoordEnd(:,1) + mapCenter(2), lineCoordEnd(:,2) + mapCenter(1)];

% % plot the big square
% for i = 1:size(lineCoordStart,1)
%   hold on
%   plot([lineCoordStart(i,1), lineCoordEnd(i,1)], [lineCoordStart(i,2), lineCoordEnd(i,2)], 'LineWidth', 3);
% end

%% Creation of the main lines
isocMainLineCoordStart = [];
isocMainLineCoordEnd = [];
numOfMainLine = 1;
for i = 1:size(lineCoordStart,1)
    %i = 6;
    c = improfile(~mapUnderTest, [lineCoordStart(i,1), lineCoordEnd(i,1)], [lineCoordStart(i,2), lineCoordEnd(i,2)]);
%   hold on
    for j = 2:size(c,1)-2
        hold on
        if (c(j-1) == 0 || isnan(c(j-1))) && c(j) == 1
%              plot(((lineCoordEnd(i,1) - lineCoordStart(i,1)) * (j / size(c,1)) + lineCoordStart(i,1)),...
%                  ((lineCoordEnd(i,2) - lineCoordStart(i,2)) * (j / size(c,1)) + lineCoordStart(i,2)), '*-b', 'LineWidth', 3)
            isocMainLineCoordStart = [isocMainLineCoordStart; ...
                ((lineCoordEnd(i,1) - lineCoordStart(i,1)) * (j / size(c,1)) + lineCoordStart(i,1)), ...
                ((lineCoordEnd(i,2) - lineCoordStart(i,2)) * (j / size(c,1)) + lineCoordStart(i,2)), ...
                i, numOfMainLine];
        end
        if (c(j) == 0 || isnan(c(j))) && c(j-1) == 1
%              plot(((lineCoordEnd(i,1) - lineCoordStart(i,1)) * (j / size(c,1)) + lineCoordStart(i,1)),...
%                  ((lineCoordEnd(i,2) - lineCoordStart(i,2)) * (j / size(c,1)) + lineCoordStart(i,2)), 'o-r', 'LineWidth', 3)
            isocMainLineCoordEnd = [isocMainLineCoordEnd; ...
                ((lineCoordEnd(i,1) - lineCoordStart(i,1)) * (j / size(c,1)) + lineCoordStart(i,1)), ...
                ((lineCoordEnd(i,2) - lineCoordStart(i,2)) * (j / size(c,1)) + lineCoordStart(i,2)), ...
                i, numOfMainLine + 1];
            numOfMainLine = numOfMainLine + 1;
        end
    end
end

% for i = 1:size(lineCoordStart,1)
%    plot([lineCoordStart(i,1), lineCoordEnd(i,1)], [lineCoordStart(i,2), lineCoordEnd(i,2)], '-k', 'LineWidth', 1);
% end
% 
% for i = 1:size(isocMainLineCoordStart,1)
%     plot([isocMainLineCoordStart(i,1), isocMainLineCoordEnd(i,1)], [isocMainLineCoordStart(i,2), isocMainLineCoordEnd(i,2)], '*-', 'LineWidth', 2);
% end

%% Rotation back to the original position 'norm', because of easier calculations at connectivity graph
isocMainLineCoordStartNorm = [isocMainLineCoordStart(:,1) - mapCenter(2), isocMainLineCoordStart(:,2) - mapCenter(1)];
isocMainLineCoordStartNorm = [cos(-lineAngle),-sin(-lineAngle); sin(-lineAngle),cos(-lineAngle)] * isocMainLineCoordStartNorm(:,1:2)';
isocMainLineCoordStartNorm = isocMainLineCoordStartNorm';
isocMainLineCoordEndNorm = [isocMainLineCoordEnd(:,1) - mapCenter(2), isocMainLineCoordEnd(:,2) - mapCenter(1)];
isocMainLineCoordEndNorm = [cos(-lineAngle),-sin(-lineAngle); sin(-lineAngle),cos(-lineAngle)] * isocMainLineCoordEndNorm(:,1:2)';
isocMainLineCoordEndNorm = isocMainLineCoordEndNorm';
% figure; hold on
% for i = 1:size(isocMainLineCoordStartNorm,1)
%     plot([isocMainLineCoordStartNorm(i,1), isocMainLineCoordEndNorm(i,1)], [isocMainLineCoordStartNorm(i,2), isocMainLineCoordEndNorm(i,2)], '*-r', 'LineWidth', 4);
%     plot([isocMainLineCoordStartNorm(i,1), isocMainLineCoordEndNorm(i,1)], [isocMainLineCoordStartNorm(i,2) + lineDistance, isocMainLineCoordEndNorm(i,2) + lineDistance], '*-k', 'LineWidth', 6);
% end

%% Detrermination of the connectivity graph
st = [];
i = min(isocMainLineCoordEnd(:,3));
while i < max(isocMainLineCoordEnd(:,3))
    i = i + 1;
    prevRow = find(isocMainLineCoordEnd(:,3) == i-1);
    thisRow = find(isocMainLineCoordEnd(:,3) == i);
    for t = 1:size(thisRow, 1)
        for p = 1:size(prevRow, 1)
          % if the lines overlap each other mak a source - target (st) graph obje
            if  ~((isocMainLineCoordEndNorm(thisRow(t), 1)  < isocMainLineCoordStartNorm(prevRow(p), 1)   && ...
                 isocMainLineCoordEndNorm(thisRow(t), 1)  < isocMainLineCoordEndNorm(prevRow(p), 1)   ) || ...
                (isocMainLineCoordStartNorm(thisRow(t), 1) > isocMainLineCoordStartNorm(prevRow(p), 1)   && ...
                 isocMainLineCoordStartNorm(thisRow(t), 1) > isocMainLineCoordEndNorm(prevRow(p), 1)   ))
                st = [thisRow(t), prevRow(p); st];                
            end
        end
    end
end
st = st';
lineGraphSource = st(1,:);
lineGraphTarget = st(2,:);
lineGraph = graph(lineGraphSource, lineGraphTarget);
xCoordOfLines = ((isocMainLineCoordStartNorm(:,1) + isocMainLineCoordEndNorm(:,1)) / 2)';
yCoordOfLines = ((isocMainLineCoordStartNorm(:,2) + isocMainLineCoordEndNorm(:,2)) / 2)';

%% Plot graph
%hold on; plot(lineGraph, 'XData', xCoordOfLines, 'YData', yCoordOfLines, 'MarkerSize', 12, 'LineWidth', 4);

%% Plot main lines
%for i = 1:size(isocMainLineCoordStart,1)
%    plot([isocMainLineCoordStart(i,1), isocMainLineCoordEnd(i,1)], [isocMainLineCoordStart(i,2), isocMainLineCoordEnd(i,2)], '*-', 'LineWidth', 2);
%end


%% Calculate length of the path



end % end of the IsocFindMainLines function 