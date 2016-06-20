function [EmptyArea] = emptyLaser(scan, theta, mapZoom, probailityConstant, disp)
%% Empty areas
% test: emptyLaser(laserScan, neoPose.theta, 50, 500, 1)
% global laserScan; scan = laserScan(:,~isnan(laserScan(1,:))); mapZoom = 20; disp = 1; theta = neoPose.theta; probailityConstant = 2;

maxRadius = 4; % circle of maximum measurement
rotAngle = - pi / 2; 
scan = [cos(rotAngle),-sin(rotAngle);sin(rotAngle),cos(rotAngle);] * scan(1:2,:); % rotate laser scanner data (orientation)


theta = mod(-theta - pi, 2*pi); % modulo theta between 0 and 2 pi - wrap
laserAngles = mod(atan2(scan(1,:),scan(2,:)), 2*pi); % the measurement angles, wrap to 2pi
laserDistan = sqrt(scan(1,:).^2+scan(2,:).^2); % the measurement distances to the angles
emptyAngles = []; % the empty area angles
allAngles = -0.6*pi : 0.05 : 0.6*pi;
allAngles = mod(allAngles + theta , 2*pi); % wrap to 2pi
for i = 1:size(allAngles,2)
    values=laserAngles(laserAngles(:)>=allAngles(i)-0.02 & laserAngles(:)<=allAngles(i)+0.02);
    if size(values) <= 1
        emptyAngles = [emptyAngles, allAngles(i)];
    end
end
emptyDistan = ones(size(emptyAngles))*5; % the distances to the angles at maximum measurement raduis
% add the laser measurement, the empty areas and the 0 point (the V sahpe) to the results
results = [laserDistan emptyDistan 0.1; laserAngles emptyAngles mod(theta+pi, 2*pi)]; % first row distance; second angles
results = sortrows(results.',2).'; % sort because continuous connecting
mapCent = (mapZoom+1)*maxRadius*1.6; % center x and y of the map
mapSize = (mapZoom+1)*2*maxRadius*1.6; % verical and horizontal size of the map
EmptyArea = logical(false(int32(mapSize), int32(mapSize)));
xW = zeros(1, size(results, 2));
yW = zeros(1, size(results, 2));
% create the 
for i = 1:size(results, 2)
    xW(i) = int32(mapCent + results(1, i) * mapZoom*sin(results(2, i) + rotAngle));
    yW(i) = int32(mapCent + results(1, i) * mapZoom*cos(results(2, i) + rotAngle));
end
xW = xW(xW ~= 0); % filter out zeros
yW = yW(yW ~= 0);
for i = 1:size(xW, 2)-1
    try
        EmptyArea(xW(i), yW(i)) = 1; % increase the probability (the actulal measurement dots)
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


% line to the last element (to close the polygon)
cLine = CalcLine(xW(1), yW(1), xW(end), yW(end));
for j = 1:size(cLine, 1)
    EmptyArea(cLine(j,1), cLine(j,2)) = 1; % lines between dots
end

EmptyArea = imfill(EmptyArea, 'holes'); % imfill - fill image holes
EmptyArea = (double(EmptyArea) * (probailityConstant - 1)) + 1;



%Display the result if disp is 1
if disp == 1
    %close all
    
    fig1 = figure;
    hold on
    plot(scan(1,:), scan(2,:), '*');
    plot(sin(allAngles(:))*maxRadius, cos(allAngles(:))*maxRadius, 'k.'); % the circle of maximum measurements
    plot(sin(emptyAngles(:))*maxRadius, cos(emptyAngles(:))*maxRadius, 'r.'); % the circle where was no measurement
    plot([0 sin(theta)*6],[0 cos(theta)*6], '--', 'LineWidth', 2);
    plot([0 sin(theta+0.6*pi)*6],[0 cos(theta+0.6*pi)*6], '--', 'LineWidth', 2);
    plot([0 sin(theta-0.6*pi)*6],[0 cos(theta-0.6*pi)*6], '--', 'LineWidth', 2);
    hold off
        
    hold on
    fig2 = figure;    
    cmap = flag;
    colormap(cmap(1:8,1:3));
    image(EmptyArea);
    axis square;
    pbaspect([1 1 1]);
    fig2 = zoom; % zoom by default
    caxis([0,1]);
    set(fig2,'Motion','both','Enable','on'); % zoom by default
    % Make the plot larger
    %set(fig2, 'units','normalized','outerposition',[0 0 0.8 0.8]);
    % Move the GUI to the center of the screen.
    %movegui(fig2,'center');
    %sprintf('theta: %f', theta);
    colorbar;
    hold off
    
    hold on
    fig3 = figure;
    fig3 = plot(results(1,:).*sin(results(2,:)), results(1,:).*cos(results(2,:)), '*-');
    %         cc=hsv(size(results, 2));
    %         for i = 1:size(results, 2)
    %             fig3 = plot(results(1,i).*sin(results(2,i)), results(1,i).*cos(results(2,i)), 'color', cc(i,:), 'Marker', '*', 'LineStyle', '--', 'LineWidth', 5);
    %             text(double(results(1,i).*sin(results(2,i))), double(results(1,i).*cos(results(2,i))), num2str(results(2,i)));
    %             hold on
    %         end
    hold on
    plot([0 sin(theta)*6],[0 cos(theta)*6], 'k--', 'LineWidth', 2);
    plot([0 sin(theta+0.6*pi)*6],[0 cos(theta+0.6*pi)*6], 'k--', 'LineWidth', 2);
    plot([0 sin(theta-0.6*pi)*6],[0 cos(theta-0.6*pi)*6], 'k--', 'LineWidth', 2);
    hold off
end
end

