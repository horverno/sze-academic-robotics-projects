%% MapUpdate algorithm test
%% Maps loaded from file
if(exist('map01','var') == 0)
    load('Maps01.mat');
end
%% Settings
mapUnderTest = map01;
itemSize = 60;


%% Display
h = zoom; % zoom by default
set(h,'Motion','both','Enable','on'); % zoom by default
colormap(myColorMap);
image(mapUnderTest);
%image(ThisImage);
colorbar();
%uint8


%% Algorithms



% Get sizes
[rowsBig, columnsBig] = size(mapUnderTest);
[rowsSmall, columnsSmall] = size(t);
% Specify upper left row, column of where
% we'd like to paste the small matrix.
randRow = randi([0 uint16(columnsBig-columnsSmall)],1,itemSize);
randCol = randi([0 uint16(columnsBig-columnsSmall)],1,itemSize);
randThe = randn(itemSize)*2*pi;
for i = 1:size(randRow,2)
    % Determine lower right location.
    row2 = randRow(i) + rowsSmall - 1;
    column2 = randCol(i) + columnsSmall - 1;
    t = CreateLidar(20, randThe(i));
    % Paste it.
    mapUnderTest(randRow(i):row2, randCol(i):column2) = mapUnderTest(randRow(i):row2, randCol(i):column2) + uint8(t);
    image(mapUnderTest);
    drawnow
    %pause(0.2)
end

