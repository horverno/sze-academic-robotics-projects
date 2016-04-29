function [EmptyArea] = emptyLaser(scan, theta, mapZoom, probailityConstant, disp)
%% Empty areas
% test: emptyLaser(laserScan, neoPose.theta, 50, 500, 1)
% scan = laserScan(:,~isnan(laserScan(1,:))); theta = pi/8; mapZoom = 20; probailityConstant =0.45; disp = 1; 

%scan = [3.7473595 3.7587819;0.93013006 0.90543997;0.11699983 0.11699983];
r = 3; % circle of maximum measurement

scan = [cos(-pi/2),-sin(-pi/2),0;sin(-pi/2),cos(-pi/2),0;0,0,1] * scan; % rotate laser scanner data (orientation)

theta = mod(theta , 2*pi);
laserAngles = mod(atan2(scan(1,:),scan(2,:)), 2*pi); % the measurement angles, wrap to 2pi
laserDistan = sqrt(scan(1,:).^2+scan(2,:).^2); % the measurement distances to the angles
emptyAngles = []; % the empty area angles
allAngles = -2.356 : 0.1 : 2.356;
allAngles = mod(allAngles - theta, 2*pi); % wrap to 2pi
for i = 1:size(allAngles,2)
    values=laserAngles(laserAngles(:)>=allAngles(i)-0.05 & laserAngles(:)<=allAngles(i)+0.05);
    if size(values) <= 1
        emptyAngles = [emptyAngles, allAngles(i)];
    end
end
emptyDistan = ones(size(emptyAngles))*r ;% the distances to the angles
results = [laserDistan emptyDistan; laserAngles emptyAngles]; % first row distance; second angles
%results = [results; 0 0]
results = sortrows(results.',2).'; % sort because continuous connecting
mapCent = (mapZoom+1)*r*1.6; % center x and y of the map
mapSize = (mapZoom+1)*2*r*1.6; % verical and horizontal size of the map
EmptyArea = logical(false(int32(mapSize), int32(mapSize)));
xW = zeros(1, size(results, 2));
yW = zeros(1, size(results, 2));
for i = 1:size(results, 2)
    xW(1, i) = int32(mapCent + results(1, i) * mapZoom*sin(results(2, i) - pi/2));
    yW(1, i) = int32(mapCent + results(1, i) * mapZoom*cos(results(2, i) - pi/2));
end
for i = 1:size(results, 2)-1
    try
        EmptyArea(xW(1, i), yW(1, i)) = 1; % increase the probability (the actulal measurement dots)
    catch
    end
    cLine = CalcLine(xW(i), yW(i), xW(i+1), yW(i+1));
    for j = 1:size(cLine, 1)
        try
            EmptyArea(cLine(j,1), cLine(j,2)) = 1; % increase the probability (lines between dots)
        catch
        end
    end
end


% % line to the last element (to close the polygon)  todo
% cLine = CalcLine(mapCent, mapCent, xW(size(results, 2)), yW(size(results, 2)));
% for j = 1:size(cLine, 1)
%     EmptyArea(cLine(j,1), cLine(j,2)) = 1; % lines between dots
% end
%
% % line to the first element (to close the polygon)  todo
% cLine = CalcLine(mapCent, mapCent, xW(1), yW(1));
% for j = 1:size(cLine, 1)
%     EmptyArea(cLine(j,1), cLine(j,2)) = 1; % lines between dots
% end

EmptyArea = imfill(EmptyArea, 'holes'); % imfill - fill image holes
EmptyArea = (double(EmptyArea) * (probailityConstant - 1)) + 1;



%Display the result if disp is 1
if disp == 1
    close all
    
    figure
    hold on
    plot(scan(1,:), scan(2,:), '*')
    plot(sin(allAngles(:))*r, cos(allAngles(:))*r, 'y.'); % the circle of maximum measurements
    plot(sin(emptyAngles(:))*r, cos(emptyAngles(:))*r, 'r.') % the circle where was no measurement
    %plot(sin(laserAngles(:))*r, cos(laserAngles(:))*r, 'r*')
    hold off
        
    
    figure    
    cmap = flag;
    colormap%(cmap(1:8,1:3));
    image(EmptyArea);
    axis square
    pbaspect([1 1 1])
    h = zoom; % zoom by default
    caxis([0,1])
    set(h,'Motion','both','Enable','on'); % zoom by default
    % Make the plot larger
    set(gcf, 'units','normalized','outerposition',[0 0 0.8 0.8]);
    % Move the GUI to the center of the screen.
    movegui(gcf,'center')
    colorbar
end
end

