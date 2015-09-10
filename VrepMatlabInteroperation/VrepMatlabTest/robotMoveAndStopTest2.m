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
target_position = 1.5; % 1.5 meters forward
omega = 2;
time = target_position/(r*omega);
target_angle = time * omega;

%%
i = 0;
prevPos = [0 0]; % contains the actual (2) and the previous position of the wheel (1) 
pause(1);
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 2, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 2, vrep.simx_opmode_oneshot_wait);
while turns*pi*2+pos < target_angle
    [res, pos] = vrep.simxGetJointPosition(clientID, motorRight, vrep.simx_opmode_oneshot_wait); 
    i = i + 1;
    prevPos(1) = prevPos(2);
    prevPos(2) = pos;
    if prevPos(1) > 0 && prevPos(2) < 0        
        turns = turns + 1;
    end
    plot(pos, i, '*'); % actual  wheel position -pi to +pi
    plot(target_angle, i, 'o'); % target position
    plot(turns*pi*2+pos, i, 'o', 'Color', 'r'); % cumulated wheel position
    drawnow
    hold on
end
%%
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait);
pause(1)
[rtn,neoEndPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, neoHandle1, vrep.simx_opmode_oneshot_wait);
neoMoved = neoEndPos - neoStartPos % displays the movement