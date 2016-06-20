[err,left]=vrep.simxGetObjectHandle(clientID,'wheel_left#0',vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetPosition(clientID,left,-pi,vrep.simx_opmode_oneshot_wait);