%% Connect to V-REP (if not already connected)
if(exist('vrep','var') == 0)
    [vrep, clientID] = connectVREP('127.0.0.1',19997)
end
close all

%% Get the object handle of the wheels and the start positions
[err,motorLeft] = vrep.simxGetObjectHandle(clientID, 'wheel_left#0', vrep.simx_opmode_oneshot_wait);
[err,motorRight] = vrep.simxGetObjectHandle(clientID, 'wheel_right#0', vrep.simx_opmode_oneshot_wait);
[res,motorLeftPos] = vrep.simxGetJointPosition(clientID, motorLeft, vrep.simx_opmode_oneshot_wait);
[res,motorRightPos] = vrep.simxGetJointPosition(clientID, motorRight, vrep.simx_opmode_oneshot_wait);

motorLeftStartPos = motorLeftPos;
motorRightStartPos = motorRightPos;

%% Stop the robot
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait)


%% Move the robot forward
wheelRoundLeft = 0; % number of rounds 
wheelRoundRight = 0; % number of rounds 
pause(1)
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 2, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 2, vrep.simx_opmode_oneshot_wait);
i = 0;
while (i < 250  && motorLeftStartPos + 1 > motorLeftPos)
    [res,motorLeftPos] = vrep.simxGetJointPosition(clientID, motorLeft, vrep.simx_opmode_oneshot_wait);
    i = i + 1;
    plot(motorLeftPos, i, 'o');
    plot(motorLeftStartPos+1, i, '.')
    drawnow
    hold on
end
%% Stop the robot
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait)
pause(1)
disp(['Finished start:', num2str(motorLeftStartPos), ' fin:', num2str(motorLeftPos)]); 
%{
prev_pos = abs(pos)
half_turns = 0;
target_angle = 10*pi
vrep.simxSetJointTargetVelocity(clientID, motorLeft, -2, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, -2, vrep.simx_opmode_oneshot_wait)
while 1
    [res, pos] = vrep.simxGetJointPosition(clientID, ...
        motorLeft, vrep.simx_opmode_oneshot_wait);   
    abs(abs(pos)-prev_pos)
    if abs(abs(pos)-prev_pos) > pi - prev_pos - 0.1       
        half_turns = half_turns + 1
        prev_pos = 0
    end
    if half_turns*pi+pos > target_angle
        break
    end
end
%% Stop
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait)

}%

%{

%%
[err,motorLeft] = vrep.simxGetObjectHandle(clientID, 'wheel_left#0', vrep.simx_opmode_oneshot_wait);
[err,motorRight] = vrep.simxGetObjectHandle(clientID, 'wheel_right#0', vrep.simx_opmode_oneshot_wait);
r = 0.125;
half_turns = 0;
target_position = 0.2;
omega = 2;
time = target_position/(r*omega);
target_angle = time * omega;

%%
pause(1)
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 2, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, 2, vrep.simx_opmode_oneshot_wait)
while 1
    [res, pos] = vrep.simxGetJointPosition(clientID, motorRight, vrep.simx_opmode_oneshot_wait);    
    if abs(pos) > pi-0.1        
        half_turns = half_turns + 1
    end
    if half_turns*pi+pos > target_angle
        break
    end
end
%%
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait)
pause(1)
%%
prev_pos = abs(pos)
half_turns = 0;
target_angle = 10*pi
vrep.simxSetJointTargetVelocity(clientID, motorLeft, -2, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, -2, vrep.simx_opmode_oneshot_wait)
while 1
    [res, pos] = vrep.simxGetJointPosition(clientID, ...
        motorLeft, vrep.simx_opmode_oneshot_wait);   
    abs(abs(pos)-prev_pos)
    if abs(abs(pos)-prev_pos) > pi - prev_pos - 0.1       
        half_turns = half_turns + 1
        prev_pos = 0
    end
    if half_turns*pi+pos > target_angle
        break
    end
end
%%
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait)
%}
%}
