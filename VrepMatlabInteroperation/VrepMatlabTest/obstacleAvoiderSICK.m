% A simple controller to avoid obstacles
% Motor encoder incrementation
%

laser_threshold = 0.1;
laser_threshold_sup = 9.0;
calibrated_interval = 205;
% Get object handler for both motors
[err,rw] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',...
    vrep.simx_opmode_oneshot_wait)
[err,lw] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',...
    vrep.simx_opmode_oneshot_wait)
% Get handle for laser scanner
[err,sensor1] = vrep.simxGetObjectHandle(clientID, 'SICK_S300_sensor1',...
    vrep.simx_opmode_oneshot_wait)
[err,sensor2] = vrep.simxGetObjectHandle(clientID, 'SICK_S300_sensor2',...
    vrep.simx_opmode_oneshot_wait)

velocityMagnitude = 3.0
targetvelocityR = velocityMagnitude;
targetvelocityL = targetvelocityR;
vrep.simxSetJointTargetVelocity(clientID, rw, targetvelocityR,...
    vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID, lw, targetvelocityL,...
    vrep.simx_opmode_oneshot_wait)
% The algorithm itself
while 1
    [err,res,img1] =...
        vrep.simxGetVisionSensorImage2(clientID, sensor1,...
            1, vrep.simx_opmode_oneshot_wait);
    [err,res,img2] =...
        vrep.simxGetVisionSensorImage2(clientID, sensor2,...
            1, vrep.simx_opmode_oneshot_wait);
    min_distanceL = double(min(img1(1:156)))/256
    min_distanceR = double(min(img2(135:256)))/256
    if min_distanceR < laser_threshold
        if targetvelocityR > -velocityMagnitude
            targetvelocityR = targetvelocityR - velocityMagnitude*sigmoid_simple(laser_threshold/(min_distanceR));
        else
            targetvelocityR = -velocityMagnitude;
        end
    else
        if targetvelocityR < velocityMagnitude
            targetvelocityR = targetvelocityR + velocityMagnitude*sigmoid_simple(laser_threshold/(min_distanceR));
        else
            targetvelocityR = velocityMagnitude;
        end
    end
    if min_distanceL < laser_threshold
        if targetvelocityL > -velocityMagnitude
            targetvelocityL = targetvelocityL - velocityMagnitude*sigmoid_simple(laser_threshold/(min_distanceL));
        else
            targetvelocityL = -velocityMagnitude;
        end
    else
        if targetvelocityL < velocityMagnitude
            targetvelocityL = targetvelocityL + velocityMagnitude*sigmoid_simple(laser_threshold/(min_distanceL));
        else
            targetvelocityL = velocityMagnitude;
        end
    end
    
    vrep.simxSetJointTargetVelocity(clientID, rw, targetvelocityR,...
            vrep.simx_opmode_oneshot_wait);
    vrep.simxSetJointTargetVelocity(clientID, lw, targetvelocityL,...
        vrep.simx_opmode_oneshot_wait);

end