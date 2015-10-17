%% Robot move and stop after a certain meters - orinentation test
%% Connect to V-REP (if not already connected)
if(exist('vrep','var') == 0)
    [vrep, clientID] = connectVREP('127.0.0.1',19997);
end
%vrep.simxStopSimulation(clientID, vrep.simx_opmode_oneshot_wait);
%vrep.simxStartSimulation(clientID, vrep.simx_opmode_oneshot_wait);
%close all

%%
[err,motorLeft] = vrep.simxGetObjectHandle(clientID, 'wheel_left#0', vrep.simx_opmode_oneshot_wait);
[err,motorRight] = vrep.simxGetObjectHandle(clientID, 'wheel_right#0', vrep.simx_opmode_oneshot_wait);
[err,neoHandle0] = vrep.simxGetObjectHandle(clientID, 'neobotix#0', vrep.simx_opmode_oneshot_wait);
[err,origoHandle] = vrep.simxGetObjectHandle(clientID, 'origo', vrep.simx_opmode_oneshot_wait);
[rtn,neoStartPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, origoHandle, vrep.simx_opmode_oneshot_wait);
r = 0.125;
turns = 0;
target_position = 4.0; % 
omega = 2;
time = target_position/(r*omega);
target_angle = time * omega;

vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait);

%%
i = 0;
pos = 0;
prevPos = [0 0]; % contains the actual (2) and the previous position of the wheel (1) 
pause(1);
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 1, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, -1, vrep.simx_opmode_oneshot_wait);
fig2 = figure('Name', 'Angles');
t = [0,0,0];
while turns*pi*2+pos < target_angle % the robot moves until it reaches the target
    [res, pos] = vrep.simxGetJointPosition(clientID, motorRight, vrep.simx_opmode_oneshot_wait); 
    i = i + 1;
    prevPos(1) = prevPos(2);
    prevPos(2) = pos;

    if prevPos(1) > 0 && prevPos(2) < 0 % if the wheel reaches the  
        turns = turns + 1;
    end
    res = 19;
    while (res~=vrep.simx_return_ok)
       [res,laser_scan]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
    end
    data = vrep.simxUnpackFloats(laser_scan);
    data = reshape(data,3,size(data,2)/3);
    %outer_hull3 = data(:,end-684:end);
    %outer_hull3 = outer_hull3 / 3.42; %
    [rtn,neoEndPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, origoHandle, vrep.simx_opmode_oneshot_wait);
    [rtn,neoEndTheta] = vrep.simxGetObjectOrientation(clientID, neoHandle0, -1, vrep.simx_opmode_oneshot_wait);
    % the differential robot has a pose (x,y,theta) which consists of position + orinetation 
    % to use the euler angles as theta (orientation) the following if-else is needed
    if neoEndTheta(1) < 0
        neoEndTheta(2) = (neoEndTheta(2) * - 1 - pi/2)/2;
    else
        neoEndTheta(2) = (neoEndTheta(2) + pi/2)/2;
    end
    t = [t; neoEndTheta];
    for i=1:3
        r = 3;
        a = r * cos(2*neoEndTheta(i)-pi); 
        b = r * sin(2*neoEndTheta(i)-pi);
        a1 = [0 + 3*i*r, a + 3*i*r];
        b1 = [0 , b ];
        plot(a1, b1, '--o', 'Color', rand(1,3))
        hold on
    end
    drawnow %
    hold on
end
%%
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait);
pause(1)
[rtn,neoEndPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, origoHandle, vrep.simx_opmode_oneshot_wait);
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
%figure(fig1)
%hold on

%%
%oh2 = [cos(neoEndTheta(1)),-sin(neoEndTheta(1)),0;sin(neoEndTheta(1)),cos(neoEndTheta(1)),0;0,0,1]*outer_hull2;
oh2 = outer_hull2;
oh2 = [oh2(1,:) + neoStartPos(1); oh2(2,:) + neoStartPos(2) ; oh2(3,:)];
%plot(oh2(1,:), oh2(2,:), 'ro')
