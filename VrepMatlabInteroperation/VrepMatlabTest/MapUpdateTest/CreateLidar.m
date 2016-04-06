function  [ ThisImage ] = CreateLidar(r, theta)
% usage: t = CreateLidar(20, 1.2);

allAngles = -2.356 : 0.001 : 2.356;
allAngles = allAngles + theta;
allAngles = [ones(size(allAngles)); allAngles]; %*r

mapCent = r+2; % center x and y of the map
ThisImage = false(2*r+2, 2*r+2);
xW = zeros(1, size(allAngles, 2));
yW = zeros(1, size(allAngles, 2));

for i = 1:size(allAngles, 2)
    xW(1, i) = int32(mapCent + allAngles(1, i) * r*sin(allAngles(2, i) - pi/2));
    yW(1, i) = int32(mapCent + allAngles(1, i) * r*cos(allAngles(2, i) - pi/2));
end
c = CalcLine(mapCent, mapCent, xW(i), yW(i));
for j = 1:size(c, 1)
        ThisImage(c(j,1), c(j,2)) = 1; % lines between dots
end

for i = 1:size(allAngles, 2)-1
    c = CalcLine(xW(i+1), yW(i+1), xW(i), yW(i));
    for j = 1:size(c, 1)
            ThisImage(c(j,1), c(j,2)) = 1; % lines between dots
    end
end

c = CalcLine(xW(1), yW(1), mapCent, mapCent);
for j = 1:size(c, 1)
        ThisImage(c(j,1), c(j,2)) = 1; % lines between dots
end


%fillStart = [uint8(mapCent + sin(theta-pi/2)*r/2), uint8(mapCent + cos(theta-pi/2)*r/2)]
%ThisImage(fillStart(1), fillStart(2)) = 1;

ThisImage = imfill(ThisImage, 'holes');


%% Display (debug)
%{
image(ThisImage);
h = zoom; % zoom by default
set(h,'Motion','both','Enable','on'); % zoom by default
colormap([0.0040 0.2400 0.3020; 0.6280 0.8520 0.8120; 0.8353 0.2667 0.1098; 0.9529 0.8980 0.6941]);
colorbar();
%}

end
