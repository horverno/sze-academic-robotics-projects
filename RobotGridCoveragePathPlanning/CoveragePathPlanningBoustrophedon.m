%% Coverage path planning algorithm on grid map - Boustrophedon
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
mapUnderTest = map;

%% Display map
fig1 = figure('Name', 'Map');
figure(fig1);
image(mapUnderTest);
h = zoom; % zoom by default
set(h,'Motion','both','Enable','on'); % zoom by default
colormap(myColorMap);
set(fig1,'Color',[1 1 1], 'units','pixels','outerposition',[0 0 800 800])
movegui(fig1,'center')
%measurements = regionprops(mapUnderTest, 'orientation');
%angle = measurements(1).Orientation;
%message = sprintf('The angle is %.3f degrees\n', angle);
%uiwait(msgbox(message));

%% Display debug info
% fig2 = figure('Name', 'Covered area', 'Position',[20,500,450,285]);
% set(0, 'currentfigure', fig2);

%% Boustrophedon algorithm
