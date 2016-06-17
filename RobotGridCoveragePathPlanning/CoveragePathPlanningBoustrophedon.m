%% Coverage path planning algorithm on grid map - Boustrophedon
%% Maps loaded from file
if(~exist('myColorMap','var'))
    load('Settings.mat');
    load('Map04Mit2ndFloor.mat');
end
%% Settings
close all
randCoverItemSize = 150;
mapUnderTest = map04;

%% Display map
fig1 = figure('Name', 'Map');
figure(fig1);
image(mapUnderTest);
h = zoom; % zoom by default
set(h,'Motion','both','Enable','on'); % zoom by default
colormap(myColorMap);
set(fig1,'Color',[1 1 1], 'units','pixels','outerposition',[0 0 800 800])
movegui(fig1,'center')

%% Display debug info
% fig2 = figure('Name', 'Covered area', 'Position',[20,500,450,285]);
% set(0, 'currentfigure', fig2);

%% Boustrophedon algorithm
