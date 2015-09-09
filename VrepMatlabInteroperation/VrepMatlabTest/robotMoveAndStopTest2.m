if(exist('kinect3d01','var') == 0)
    load('vrepscene01.mat');
end
close all

%%
[err,motorLeft] = vrep.simxGetObjectHandle(clientID, 'wheel_left#0', vrep.simx_opmode_oneshot_wait);
[err,motorRight] = vrep.simxGetObjectHandle(clientID, 'wheel_right#0', vrep.simx_opmode_oneshot_wait);
r = 0.125;
half_turns = 0;
target_position = 1.5; % 1.5 meters forward
omega = 2;
time = target_position/(r*omega);
target_angle = time * omega;

%%
i = 0;
pause(1)
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 2, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, 2, vrep.simx_opmode_oneshot_wait)
while 1
    [res, pos] = vrep.simxGetJointPosition(clientID, motorRight, vrep.simx_opmode_oneshot_wait); 
    plot(pos, i, '*');
    plot(target_angle, i, 'o');
    plot(half_turns*pi+pos, i, 'o', 'Color', 'r');
    drawnow
    hold on
    i = i + 1;
    if abs(pos) > pi-0.1        
        half_turns = half_turns + 1;
    end
    if half_turns*pi+pos > target_angle
        break
    end
end
%%
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait)
pause(1)