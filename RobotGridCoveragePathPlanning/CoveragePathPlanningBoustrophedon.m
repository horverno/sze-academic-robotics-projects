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
image(uint8(~mapUnderTest) ); % + uint8(bwmorph(~mapUnderTest,'skel',Inf))
h = zoom; % zoom by default
set(h,'Motion','both','Enable','on'); % zoom by default
colormap(myColorMap);
colorbar();
set(fig1,'Color',[1 1 1], 'units','pixels','outerposition',[0 0 800 800])
movegui(fig1,'center')


%% Create blobs
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
        boundary = blobs{i};
        plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 4);
    end
end

% todo: after blob recognition find the critical points which decomposes the map into sub-poygons

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
