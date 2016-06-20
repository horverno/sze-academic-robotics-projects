%% Szenergy test
%% Connect to V-REP (if not already connected)
if(exist('vrep','var') == 0)
    [vrep, clientID] = connectVREP('127.0.0.1',19997);
end

%% Settings
close all
res = [];
data = [];
neoEndTheta = pi / 2;
while (res~=vrep.simx_return_ok)
    [res,data]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
end
data = vrep.simxUnpackFloats(data);
data = reshape(data,3,size(data,2)/3);
%drawnow %
%hold on

%% Get sick data
[err, sick] = vrep.simxGetObjectHandle(0,'SICK_S300_fast#0', vrep.simx_opmode_oneshot_wait);
res = 19;

while (res~=vrep.simx_return_ok)
    [res,data]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
end
if isempty(data)
    disp('No LIDAR measurement in the simxReadStringStream. Is your simulation running?');
else
    data = vrep.simxUnpackFloats(data);
    data = reshape(data,3,size(data,2)/3);
    if size(data, 2) > 684
        %data = data(:,end-684:end);
        [~, SmallestElemIdx] = sort(data(2, :));
        data = data(:, SmallestElemIdx(1):SmallestElemIdx(2)-1);
    end
    %data = data / 3.42; %
    data = [cos(neoEndTheta(1)),-sin(neoEndTheta(1)),0;sin(neoEndTheta(1)),cos(neoEndTheta(1)),0;0,0,1]*data;
    data = horzcat([0;0;0], data, [0;0;0]);
    % plot Sick data
    fig1 = figure('Name', 'Laser scanner', 'units','normalized','position',[.1 .1 .4 .4], 'Color',[1 1 1], 'outerposition',[0 0 1 1])
    plot(data(1,:), data(2,:), '-ro',  'MarkerFaceColor', [.6 .8 .8], 'MarkerEdgeColor', [.6 .8 .8], 'MarkerSize', 10, 'LineSmoothing','on')
    axis([-2 2 0 4])
    %fig2 = figure('Name', 'Figure 2')
    %plot(data(2,:))
end