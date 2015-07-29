[err,joint1]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint1',vrep.simx_opmode_oneshot_wait);
[err,joint2]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint2',vrep.simx_opmode_oneshot_wait);
[err,joint3]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint3',vrep.simx_opmode_oneshot_wait);
[err,joint4]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint4',vrep.simx_opmode_oneshot_wait);
[err,joint5]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint5',vrep.simx_opmode_oneshot_wait);
[err,joint6]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint6',vrep.simx_opmode_oneshot_wait);
[err,joint7]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint7',vrep.simx_opmode_oneshot_wait);

vrep.simxSetJointTargetPosition(clientID,joint5,45*pi/180,vrep.simx_opmode_oneshot_wait);

[err,joint01]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint1#0',vrep.simx_opmode_oneshot_wait);
[err,joint02]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint2#0',vrep.simx_opmode_oneshot_wait);
[err,joint03]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint3#0',vrep.simx_opmode_oneshot_wait);
[err,joint04]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint4#0',vrep.simx_opmode_oneshot_wait);
[err,joint05]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint5#0',vrep.simx_opmode_oneshot_wait);
[err,joint06]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint6#0',vrep.simx_opmode_oneshot_wait);
[err,joint07]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint7#0',vrep.simx_opmode_oneshot_wait);