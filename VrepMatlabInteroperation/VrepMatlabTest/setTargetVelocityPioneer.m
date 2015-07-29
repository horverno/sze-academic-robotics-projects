function setTargetVelocityPioneer(clientID,vel_rw,vel_lw)
    vrep=remApi('remoteApi');
    [err, lw] = ...
        vrep.simxGetObjectHandle(clientID, 'LBR_iiwa_14_R820_link1',vrep.simx_opmode_oneshot_wait);
    [err, rw] = ...
        vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_rightMotor',vrep.simx_opmode_oneshot_wait);
    vrep.simxSetJointTargetVelocity(clientID, rw, vel_rw, vrep.simx_opmode_oneshot_wait);
    vrep.simxSetJointTargetVelocity(clientID, lw, vel_lw, vrep.simx_opmode_oneshot_wait);
end