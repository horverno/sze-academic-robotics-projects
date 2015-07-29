function setTargetVelocityLBR(clientID,vel_j)
    vrep=remApi('remoteApi');
    [err, lw] = ...
        vrep.simxGetObjectHandle(clientID, 'LBR_iiwa_14_R820_joint6',vrep.simx_opmode_oneshot_wait);
    vrep.simxSetJointTargetPosition(clientID, lw, vel_j, vrep.simx_opmode_oneshot_wait);
    [img1,img2]=getVisionScanner();
    plot(img1);
    plot(img2);
end