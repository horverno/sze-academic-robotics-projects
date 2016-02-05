%% Laser scanner (sick s300) test loaded from file
%%
if(exist('kinect3d01','var') == 0)
    load('vrepscene01.mat');
end

close all

scan = sick3d01;
theta = pi/2;
scan = [cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1] * scan; % rotate laser scanner data (orientation)

% circle of maximum measurement
r = 1.4;

filteredLaser = [;]; 
for n = 1:size(scan, 2)
    if ~(abs(scan(1,n)) < 0.06 & abs(scan(2,n)) < 0.06)
        filteredLaser(:,n) = scan(:,n);
    else
        filteredLaser(1,n) = NaN;
    end
end


%% Plot original sick data
f = gcf;
subplot(1,2,1);
hold on
plot(scan(1,:),scan(2,:), 'b.')
plot(filteredLaser(1,:),filteredLaser(2,:), 'k.')
laserAngles = atan2(scan(1,:),scan(2,:)); % the measurement angles 
laserDistan = sqrt(scan(1,:).^2+scan(2,:).^2); % the measurement distances to the angles 
emptyAngles = []; % the empty area angles 
allAngles = -2.356 : 0.1 : 2.356;
for i = 1:size(allAngles,2)
    values=laserAngles(laserAngles(:)>=allAngles(i)-0.05 & laserAngles(:)<=allAngles(i)+0.05);
    if size(values) <= 1
        emptyAngles = [emptyAngles, allAngles(i)];
    end
end
plot(sin(allAngles(:))*r, cos(allAngles(:))*r, 'y.'); % the circle of maximum measurements
plot(sin(emptyAngles(:))*r, cos(emptyAngles(:))*r, 'r.') % the circle where was no measurement
emptyDistan = ones(size(emptyAngles))*r ;% the distances to the angles 
axis square 
pbaspect([1 1 1])
grid on

%% Plot result
% turn again with 180 degree (cathesian vs matrix representation)
results = [laserDistan emptyDistan; laserAngles emptyAngles]; % first row distance; second angles
results = sortrows(results.',2).'; % sort because continuous connecting
mapZoom = 50;
mapCent = mapZoom * 2; % center x and y of the map
mapSize = mapZoom * 4; % verical and horizontal size of the map
Layer = logical(false(mapZoom*4, mapZoom*4));
xW = zeros(1, size(results, 2));
yW = zeros(1, size(results, 2));
for i = 1:size(results, 2)
    xW(1, i) = mapCent + int32(results(1, i) * mapZoom*sin(results(2, i)-pi/2));
    yW(1, i) = mapCent + int32(results(1, i) * mapZoom*cos(results(2, i)-pi/2));
end
for i = 1:size(results, 2)-1
    Layer(xW(1, i), yW(1, i)) = 1; % increase the probability (the actulal measurement dots)
    c = CalcLine(xW(i+1), yW(i+1), xW(i), yW(i));
    for j = 1:size(c, 1)
        Layer(c(j,1), c(j,2)) = 1; % increase the probability (lines between dots)
    end
end

c = CalcLine(xW(1), yW(1), xW(size(results, 2)), yW(size(results, 2))); % line between the first and last element (to close the polygon) 
for j = 1:size(c, 1)
        Layer(c(j,1), c(j,2)) = 1; % increase the probability (lines between dots)
end

subplot(1,2,2);
cmap = flag;
colormap(cmap(1:8,1:3));
%Layer = imfill(Layer,[51 50], 4); % fill the empty areas 
TempLayer = int16(zeros(mapSize,mapSize,3));
TempLayer(:,:,1)=int16((Layer-1*-1)*50);
FillResult = FloodFill(TempLayer,[int32(mapCent); int32(mapCent)],2); % flood fill (image, from where, tolerance)
Layer(FillResult) = 1;
image(Layer);
axis square 
pbaspect([1 1 1])


%%
h = zoom; % zoom by default
caxis([0,1])
set(h,'Motion','both','Enable','on'); % zoom by default
% Make the plot larger
set(gcf, 'units','normalized','outerposition',[0 0 0.8 0.8]);
% Move the GUI to the center of the screen.
movegui(f,'center')
colorbar
