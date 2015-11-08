close all
load('map02.mat')
load('scan02.mat')

%% decalaration
mapZoom = 50;
conv = [0, 1/8, 0; 1/8, 1/2, 1/8; 0, 1/8, 0]; %convolution filter
mapSize = size(RobotPathLayer, 1);
tryNum = 20; % number of tryouts
pX = 380; % original x
pY = 312; % original y
pTheta = 0; % original theta 5.892
rX = int64(rand(tryNum,1)*90-45+pX); % random x values
rY = int64(rand(tryNum,1)*90-45+pY); % random y values
rTheta = rand(tryNum,1) * 2 * pi; % random theta values
rX(2,1) = pX;
rY(2,1) = pY;
rTheta(2,1) = 0;
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
    Layer = conv2(Layer, conv)*1.6;
    Layer = Layer(1:mapSize,1:mapSize);
    ModRobotPathLayer = conv2(RobotPathLayer, conv)*1.6;
    ModRobotPathLayer = ModRobotPathLayer(1:mapSize,1:mapSize);
    ModRobotPathLayer = ModRobotPathLayer - Layer;
    ModRobotPathLayer(ModRobotPathLayer<=0)=0;
    image(ModRobotPathLayer + 2 * Layer);
    res(i,1) = sum(sum(ModRobotPathLayer));
    pause(0.1);
end
close(fig5)
%% results
fig4 = figure('Name', 'Results', 'NumberTitle','off');
hold on
plot(res, 'b');
plot(rX, 'g');
plot(rY, 'r');

fig3 = figure('Name', 'Results on Map', 'NumberTitle','off'); 
minRes = find(res==min(res));
colormap(myColorMap)
for i = 1:size(minRes, 1)
    Layer = DrawWall(laserScan, rX(minRes(i), 1), rY(minRes(i), 1), pTheta, mapZoom, mapSize);
    image(RobotPathLayer /3 + Layer * 1.5);
end
colorbar
