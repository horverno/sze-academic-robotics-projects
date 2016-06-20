close all
load('map03.mat')
load('scan03.mat')

%% decalaration
mapZoom = 50;
conv = [0, 1/8, 0; 1/8, 1/2, 1/8; 0, 1/8, 0]; %convolution filter
mapSize = size(WallLayer, 1);
tryNum = 20; % number of tryouts
pX = 340; % original x
pY = 426; % original y
pTheta = 0; % original theta 1.534
rX = int64(rand(tryNum,1)*60-30+pX); % random x values
rY = int64(rand(tryNum,1)*60-30+pY); % random y values
rTheta = rand(tryNum,1)*0.4-0.2+pTheta; % random theta values
rX(2,1) = pX;
rY(2,1) = pY;
rTheta(2,1) = pTheta;
res = zeros(tryNum, 1); % results - how good each iteration is 
myColorMap = ([autumn; ones(6,3); flipud(winter); zeros(1,3)]); % the color map for display
close all

%% search
colormap(myColorMap)
fig1 = figure('Name', 'Original map and original laser', 'NumberTitle','off');
colormap(myColorMap)
subplot(1,2,1), caxis([0,1]), image(WallLayer, 'CDataMapping','scaled'), shading flat; colorbar, title('Original map')
Laser = 0.5 + (DrawWall(laserScan, pX, pY, pTheta, mapZoom, mapSize)/60);
colormap(myColorMap)
subplot(1,2,2), caxis([0,1]), image(Laser, 'CDataMapping','scaled'), shading flat; colorbar, title('Original laser')
scrsz = get(groot,'ScreenSize');
fig5 = figure('Name', 'Meantime results','Position',[0 0 scrsz(3) scrsz(4)], 'NumberTitle','off');
for i = 1:size(rX, 1)
    Laser = DrawWall(laserScan, rX(i, 1), rY(i, 1), pTheta, mapZoom, mapSize);
    Laser = conv2(Laser, conv, 'same')*1.6;
    ModWallLayer = conv2(WallLayer, conv, 'same')*1.6;
    ModWallLayer = ModWallLayer - Laser;
    ModWallLayer(ModWallLayer<=0)=0;
    image(ModWallLayer + 2 * Laser);
    res(i,1) = sum(sum(ModWallLayer));
    %pause(0.1);
end
close(fig5)
%% results
%fig4 = figure('Name', 'Results', 'NumberTitle','off');
%hold on
%plot(res, 'b');
%plot(rX, 'g');
%plot(rY, 'r');

fig3 = figure('Name', 'Results on Map', 'NumberTitle','off'); 
[minRes, minResIndex] = sort(res);
minRes = minRes(1:5); % first 5 best result
minResIndex = minResIndex(1:5); % first 5 best result's index
colormap(myColorMap)
caxis([0,1])
Laser = DrawWall(laserScan, rX(minResIndex(1), 1), rY(minResIndex(1), 1), pTheta, mapZoom, mapSize);
image(((WallLayer * 5 + Laser * 2)/200) + 0.5,'CDataMapping','scaled');
for i = 1:size(minRes, 1)
    fprintf('Good results: x:%d y:%d theta:%5.2f result: %d\n',rX(minResIndex(i), 1), rY(minResIndex(i), 1), rTheta(minResIndex(i), 1), res(minResIndex(i), 1))
end
colorbar
caxis([0,1])
