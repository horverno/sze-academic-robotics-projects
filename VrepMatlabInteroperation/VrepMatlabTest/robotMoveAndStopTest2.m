%% Robot move and stop after a certain meters
%% Connect to V-REP (if not already connected)
if(exist('vrep','var') == 0)
    [vrep, clientID] = connectVREP('127.0.0.1',19997);
end
close all

%%
[err,motorLeft] = vrep.simxGetObjectHandle(clientID, 'wheel_left#0', vrep.simx_opmode_oneshot_wait);
[err,motorRight] = vrep.simxGetObjectHandle(clientID, 'wheel_right#0', vrep.simx_opmode_oneshot_wait);
[err,neoHandle0] = vrep.simxGetObjectHandle(clientID, 'neobotix#0', vrep.simx_opmode_oneshot_wait);
[err,neoHandle1] = vrep.simxGetObjectHandle(clientID, 'neobotix#1', vrep.simx_opmode_oneshot_wait);
[rtn,neoStartPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, neoHandle1, vrep.simx_opmode_oneshot_wait);
r = 0.125;
turns = 0;
target_position = 0.8; % 1.8 meters forward
omega = 2;
time = target_position/(r*omega);
target_angle = time * omega;

%% Get sick data
[err, sick] = vrep.simxGetObjectHandle(0,'SICK_S300_fast#0', vrep.simx_opmode_oneshot_wait);
res = 19;

while (res~=vrep.simx_return_ok)
    [res,laser_scan]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
end

data = vrep.simxUnpackFloats(laser_scan);
data = reshape(data,3,size(data,2)/3);
outer_hull1 = data(:,end-684:end);
outer_hull1 = outer_hull1 / 3.42; %
outer_hull1 = [outer_hull1(1,:) ; (outer_hull1(2,:) .* -1); (outer_hull1(3,:) - 0.17)]; % flip laser scanner data according Y, move down according Z
fig1 = figure('Name', 'Laser scanner');
daspect([1 1 1])
plot(outer_hull1(1,:),outer_hull1(2,:), '*')


%%
i = 0;
pos = 0;
prevPos = [0 0]; % contains the actual (2) and the previous position of the wheel (1) 
pause(1);
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 2, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 2, vrep.simx_opmode_oneshot_wait);
fig2 = figure('Name', 'Wheel movement');
while turns*pi*2+pos < target_angle % the robot moves until it reaches the target
    [res, pos] = vrep.simxGetJointPosition(clientID, motorRight, vrep.simx_opmode_oneshot_wait); 
    i = i + 1;
    prevPos(1) = prevPos(2);
    prevPos(2) = pos;
    if prevPos(1) > 0 && prevPos(2) < 0 % if the wheel reaches the  
        turns = turns + 1;
    end
    plot(i, pos, '*'); % actual  wheel position -pi to +pi
    plot(i, target_angle, '-'); % target position
    plot(i, turns*pi*2+pos, 'o', 'Color', 'r'); % cumulated wheel position
    drawnow
    hold on
end
%%
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait);
pause(1)
[rtn,neoEndPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, neoHandle1, vrep.simx_opmode_oneshot_wait);
neoMoved = neoEndPos - neoStartPos % displays the movement

%% Get sick data
[err, sick] = vrep.simxGetObjectHandle(0,'SICK_S300_fast#0', vrep.simx_opmode_oneshot_wait);
res = 19;

while (res~=vrep.simx_return_ok)
    [res,laser_scan]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
end

data = vrep.simxUnpackFloats(laser_scan);
data = reshape(data,3,size(data,2)/3);
outer_hull2 = data(:,end-684:end);
outer_hull2 = outer_hull2 / 3.42; %
outer_hull2 = [outer_hull2(1,:) ; (outer_hull2(2,:) .* -1); (outer_hull2(3,:) - 0.17)]; % flip laser scanner data according Y, move down according Z
%figure('Name', 'Laser scanner')
figure(fig1)
hold on
plot(outer_hull2(1,:), outer_hull2(2,:), 'ro')
