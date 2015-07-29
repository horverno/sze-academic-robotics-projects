[err0, jointLBR] = vrep.simxGetObjectHandle(clientID,'LBR_iiwa_14_R820_link4',vrep.simx_opmode_oneshot_wait)
[err,pos] = vrep.simxGetObjectPosition(clientID,jointLBR,-1,vrep.simx_opmode_oneshot_wait)
[err,ori] = vrep.simxGetObjectOrientation(clientID,jointLBR,-1,vrep.simx_opmode_oneshot_wait)