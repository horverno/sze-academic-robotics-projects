%% MapUpdate algorithm test
%% Maps loaded from file
if(exist('map01','var') == 0)
    load('Maps01.mat');
end
%% Settings
close all
randCoverItemSize = 150;
mapUnderTest = map01;
mapUnderTest = uint8((int8(mapUnderTest) - 1)*-1);
radius = 60;
coveredAreaMin = 0.75;

%% Display more
fig2 = figure('Name', 'Covered area', 'Position',[20,500,450,285]);
set(0, 'currentfigure', fig2);

%% Display map
fig1 = figure('Name', 'Map');
figure(fig1);
image(mapUnderTest);
h = zoom; % zoom by default
set(h,'Motion','both','Enable','on'); % zoom by default
colormap(myColorMap);
colorbar();
set(fig1,'Color',[1 1 1], 'units','pixels','outerposition',[0 0 800 800])
movegui(fig1,'center')

%% Algorithms
t = CreateLidar(radius, 0);
% Get sizes
[rowsBig, columnsBig] = size(mapUnderTest);
[rowsSmall, columnsSmall] = size(t) ;
% Specify upper left row, column of where
% we'd like to paste the small matrix.
randRow = [];
randCol = [];
for i = 1:randCoverItemSize
   r1 =  randi([1 uint16(columnsBig-columnsSmall)],1);
   r2 =  randi([1 uint16(columnsBig-columnsSmall)],1);
   try
   if mapUnderTest(r1 + randCoverItemSize, r2 + randCoverItemSize) == 1
       randRow = [randRow, r1];
       randCol = [randCol, r2];
   end
   catch end
end
randThe = randn(randCoverItemSize)*2*pi;
original = sum(mapUnderTest(:));
res = [];
i = 1;
while (1 - sum(mapUnderTest(:)) / original) < coveredAreaMin && i < randCoverItemSize
    i = i + 1;
    res = [res, 1 - sum(mapUnderTest(:)) / original];
    set(0, 'currentfigure', fig2);  %# for figures
    plot(res, 'bo-');
    % Determine lower right location.
    row2 = (randRow(i) + rowsSmall - 1);
    column2 = (randCol(i) + columnsSmall - 1);
    t = CreateLidar(radius, randThe(i));
    % Paste it.
    mapUnderTest(randRow(i):row2, randCol(i):column2) = uint8(mapUnderTest(randRow(i):row2, randCol(i):column2) - uint8(t));
    %mapUnderTest(row2, column2) = 4;
    figure(fig1);
    shg %  bring figure to front
    image(mapUnderTest);
    drawnow
    %pause(0.2)
end

