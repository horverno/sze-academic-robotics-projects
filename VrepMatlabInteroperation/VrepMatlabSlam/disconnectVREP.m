function disconnectVREP(vrep, clientID)
    vrep.simxGetPingTime(clientID);
    vrep.simxFinish(clientID);
    vrep.delete();
end