[err,left]=vrep.simxGetObjectHandle(clientID,'wheel_left#0',vrep.simx_opmode_oneshot_wait)
[err,right]=vrep.simxGetObjectHandle(clientID,'wheel_right#0',vrep.simx_opmode_oneshot_wait)
vrep.simxSetJointTargetVelocity(clientID,left,10,vrep.simx_opmode_oneshot)
vrep.simxSetJointTargetVelocity(clientID,right,10,vrep.simx_opmode_oneshot)