close all
%% decalaration
mapZoom = 50;
conv = [0, 1/8, 0; 1/8, 1/2, 1/8; 0, 1/8, 0]; %convolution filter
mapSize = size(RobotPathLayer, 1);
tryNum = 20;
pX = 300; % original x
pY = 300; % original y
pTheta = 0; % original theta
rX = int64(rand(tryNum,1)*mapSize); % random x values
rY = int64(rand(tryNum,1)*mapSize); % random y values
rTheta = rand(tryNum,1) * 2 * pi; % random theta values
res = zeros(tryNum,1); % results - how good each iteration is


%% search
fig1 = figure('Name', 'Original Map');
image(RobotPathLayer);
Layer = DrawWall(laserScan, pX, pY, pTheta, mapZoom, mapSize);
fig2 = figure('Name', 'Original Laser');
image(Layer);
for i = 1:size(rX, 1)
    Layer = DrawWall(laserScan, rX(i, 1), rY(i, 1), 0, mapZoom, mapSize);
    Layer = conv2(Layer, conv)*1.6;
    Layer = Layer(1:mapSize,1:mapSize);
    ModRobotPathLayer = conv2(RobotPathLayer, conv)*1.6;
    ModRobotPathLayer = ModRobotPathLayer(1:mapSize,1:mapSize);
    ModRobotPathLayer = ModRobotPathLayer - Layer;
    %image(ModRobotPathLayer + 2 * Layer);
    res(i,1) = sum(sum(ModRobotPathLayer));
    %pause(0.001);
end

%% results
fig3 = figure('Name', 'Results on Map'); 
minRes = find(res==min(res));
for i = 1:size(minRes, 1)
    image(ModRobotPathLayer + 2 * Layer);
end
fig4 = figure('Name', 'Results');
plot(res);