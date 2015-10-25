%% Robot move and stop after a certain meters - map building
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
target_position = 1.0; % 
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
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 2, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 2, vrep.simx_opmode_oneshot_wait);
fig2 = figure('Name', 'Mapping');
thetaHistory = [0];
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
    outer_hull3 = data(:,end-684:end);
    [rtn,neoEndPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, origoHandle, vrep.simx_opmode_oneshot_wait);
    [rtn,neoEndTheta] = vrep.simxGetObjectOrientation(clientID, neoHandle0, origoHandle, vrep.simx_opmode_oneshot_wait);
    if neoEndTheta(1) < 0
        neoEndTheta(2) = (neoEndTheta(2) * - 1 - pi/2)/2;
    else
        neoEndTheta(2) = (neoEndTheta(2) + pi/2)/2;
    end
    thetaHistory = [thetaHistory; neoEndTheta(2)];
    outer_hull3 = [outer_hull3(1,:) ; (outer_hull3(2,:) .* -1); (outer_hull3(3,:) - 0.17)]; % flip laser scanner data according Y, move down according Z
    thetaRotate = (2 * neoEndTheta(2) - pi);
    oh3_ = [;]; % filtering the own contour of the robot from the laser scanner measurement
    for n = 1:size(outer_hull3, 2)
        if ~(abs(outer_hull3(1,n)) < 0.3 & abs(outer_hull3(2,n)) < 0.3)
            oh3_(1,n) = outer_hull3(1,n);
            oh3_(2,n) = outer_hull3(2,n); 
            oh3_(3,n) = outer_hull3(3,n);            
        end
    end
    outer_hull3 = oh3_;
    oh3 = [cos(thetaRotate),-sin(thetaRotate),0;sin(thetaRotate),cos(thetaRotate),0;0,0,1]*outer_hull3; % rotate laser scanner data (orientation)
    oh3 = [oh3(1,:) + neoEndPos(1); oh3(2,:) + neoEndPos(2); oh3(3,:)]; % move laser scanner data (position)
    plot(oh3(1,:),oh3(2,:), '.', 'Color', rand(1,3))
    drawnow %
    hold on
end
%%
vrep.simxSetJointTargetVelocity(clientID, motorLeft, 0, vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetVelocity(clientID, motorRight, 0, vrep.simx_opmode_oneshot_wait);
pause(1)
[rtn,neoEndPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, origoHandle, vrep.simx_opmode_oneshot_wait);
neoMoved = neoEndPos - neoStartPos; % displays the movement

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
