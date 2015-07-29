% A simple controller to avoid obstacles
% Motor encoder incrementation
%

laser_threshold = 2.0
laser_threshold_sup = 9.0
% Get object handler for both motors
[err,rw] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',...
    vrep.simx_opmode_oneshot_wait)
[err,lw] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',...
    vrep.simx_opmode_oneshot_wait)
% Get handle for laser scanner
[err,sensor] = vrep.simxGetObjectHandle(clientID, 'LaserScannerLaser_2D',...
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
    [err,result,poi,i,v] =...
        vrep.simxReadProximitySensor(clientID, sensor, ...
        vrep.simx_opmode_oneshot_wait);
    if result && laser_threshold_sup > norm(poi)
        if (norm(poi) < laser_threshold)
            if targetvelocityR > -velocityMagnitude
                targetvelocityR = targetvelocityR...
                    - velocityMagnitude*sigmoid_simple(1/(norm(poi)*1000));
            end
        else
            if targetvelocityR < velocityMagnitude
                targetvelocityR = targetvelocityR...
                    + velocityMagnitude*sigmoid_simple(1/(norm(poi)*1000));
            end
        end
        vrep.simxSetJointTargetVelocity(clientID, rw, targetvelocityR,...
            vrep.simx_opmode_oneshot_wait);
    else
        targetvelocityR = velocityMagnitude;
    end
end