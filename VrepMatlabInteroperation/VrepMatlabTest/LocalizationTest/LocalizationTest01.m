close all
load('map02.mat')
load('scan02.mat')

%% decalaration
mapZoom = 50;
conv = [0, 1/8, 0; 1/8, 1/2, 1/8; 0, 1/8, 0]; %convolution filter
mapSize = size(RobotPathLayer, 1);
tryNum = 200; % number of tryouts
pX = 380; % original x
pY = 312; % original y
pTheta = 0; % original theta 5.892
rX = int64(rand(tryNum,1)*60-30+pX); % random x values
rY = int64(rand(tryNum,1)*60-30+pY); % random y values
rTheta = rand(tryNum,1)*0.4-0.2+pTheta; % random theta values
rX(2,1) = pX;
rY(2,1) = pY;
rTheta(2,1) = pTheta;
res = zeros(tryNum, 1); % results - how good each iteration is 
myColorMap = ([1, 1, 1; jet; zeros(35, 3)]); % the color map for display
close all

%% search
fig1 = figure('Name', 'Original Map', 'NumberTitle','off');
image(RobotPathLayer);
Layer = DrawWall(laserScan, pX, pY, pTheta, mapZoom, mapSize);
fig2 = figure('Name', 'Original Laser', 'NumberTitle','off');
image(Layer);
scrsz = get(groot,'ScreenSize');
fig5 = figure('Name', 'Meantime results','Position',[0 0 scrsz(3) scrsz(4)], 'NumberTitle','off');
for i = 1:size(rX, 1)
    Layer = DrawWall(laserScan, rX(i, 1), rY(i, 1), pTheta, mapZoom, mapSize);
    Layer = conv2(Layer, conv, 'same')*1.6;
    ModRobotPathLayer = conv2(RobotPathLayer, conv, 'same')*1.6;
    ModRobotPathLayer = ModRobotPathLayer - Layer;
    ModRobotPathLayer(ModRobotPathLayer<=0)=0;
    image(ModRobotPathLayer + 2 * Layer);
    res(i,1) = sum(sum(ModRobotPathLayer));
    %pause(0.1);
end
close(fig5)
%% results
fig4 = figure('Name', 'Results', 'NumberTitle','off');
hold on
plot(res, 'b');
plot(rX, 'g');
plot(rY, 'r');

fig3 = figure('Name', 'Results on Map', 'NumberTitle','off'); 
[minRes, minResIndex] = sort(res);
minRes = minRes(1:5); % first 5 best result
minResIndex = minResIndex(1:5); % first 5 best result's index
colormap(myColorMap)
Layer = DrawWall(laserScan, rX(minResIndex(1), 1), rY(minResIndex(1), 1), pTheta, mapZoom, mapSize);
image(RobotPathLayer /3 + Layer * 1.5);
for i = 1:size(minRes, 1)
    fprintf('Good results: x:%d y:%d theta:%5.2f result: %d\n',rX(minResIndex(i), 1), rY(minResIndex(i), 1), rTheta(minResIndex(i), 1), res(minResIndex(i), 1))
end
colorbar
