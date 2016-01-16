%% Laser scanner (sick s300) test loaded from file
%%
if(exist('kinect3d01','var') == 0)
    load('vrepscene01.mat');
end

close all

scan = sick3d02;
theta = pi/2;
scan = [cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1] * scan; % rotate laser scanner data (orientation)

% circle of maximum measurement
r = 1.4;
ang1=0:0.05:2*pi*3/4; 
xp=r*cos(ang1-pi/4);
yp=r*sin(ang1-pi/4);

    filteredLaser = [;]; 
    for n = 1:size(scan, 2)
        if ~(abs(scan(1,n)) < 0.06 & abs(scan(2,n)) < 0.06)
            filteredLaser(1,n) = scan(1,n);
            filteredLaser(2,n) = scan(2,n); 
            filteredLaser(3,n) = scan(3,n);
        else
            filteredLaser(1,n) = NaN;
            filteredLaser(2,n) = NaN; 
            filteredLaser(3,n) = NaN;
        end
    end



%% Plot original sick data

% Create the figure handler
fh = figure('Visible','off','Position',[360,500,450,285],'NumberTitle','off');
set(gcf, 'units','normalized','outerposition',[0 0 0.8 0.8]); 
% Move the GUI to the center of the screen.
movegui(fh,'center')
% Make the GUI visible.
set(fh,'Visible','on');
subplot(1,3,1);
plot(scan(1,:),scan(2,:), 'r')
axis square 
pbaspect([1 1 1])


%% Plot result
subplot(1,3,2);
hold on
plot(scan(1,:),scan(2,:), 'b.')
plot(filteredLaser(1,:),filteredLaser(2,:), 'k.')
laserAngles = atan2(scan(1,:),scan(2,:)); % the measurement angles 
%laserAngles = sort(laserAngles);
laserDistan = sqrt(scan(1,:).^2+scan(2,:).^2); % the measurement distances to the angles 
%plot(sin(yT(:))*r, cos(yT(:))*r, 'r.')
emptyAngles = []; % the empty area angles 
ang2=-2.356:0.1:2.356;
for i = 1:size(ang2,2)
    values=laserAngles(laserAngles(:)>=ang2(i)-0.05 & laserAngles(:)<=ang2(i)+0.05);
    if size(values) <= 1
        emptyAngles = [emptyAngles, ang2(i)];
    end
end
plot(sin(emptyAngles(:))*r, cos(emptyAngles(:))*r, 'r.') % the circle where was no measurement
emptyDistan = ones(size(emptyAngles))*r ;% the distances to the angles 
%plot(xp,yp, 'b.'); % the circle of maximum measurements
axis square 
pbaspect([1 1 1])
grid on

%% Plot result
% turn again with 180 degree (cathesian vs matrix representation)
results = [laserDistan emptyDistan; laserAngles emptyAngles]; % first row distance; second angles
results = sortrows(results.',2).';
Layer = logical(false(200, 200));
mapZoom = 50;
xW = zeros(size(results, 2));
yW = zeros(size(results, 2));
for i = 1:size(results, 2)
    xW(i) = 100 + int64(results(1, i) * mapZoom*sin(results(2, i)-pi/2));
    yW(i) = 100 + int64(results(1, i) * mapZoom*cos(results(2, i)-pi/2));
end
for i = 1:size(results, 2)-1
    Layer(xW(i), yW(i)) = 1; % increase the probability
    c = CalcLine(xW(i+1), yW(i+1), xW(i), yW(i));
    for j = 1:size(c, 1)-1
        Layer(c(j,1), c(j,2)) = 1; % increase the probability
    end
end

subplot(1,3,3);
colormap([zeros(1,3); ones(1,3)]);
%Layer = imfill(Layer,[51 50], 4); % fill the empty areas 
image(Layer)
axis square 
pbaspect([1 1 1])

%%
h = zoom; % zoom by default
caxis([0,1])
set(h,'Motion','both','Enable','on'); % zoom by default
