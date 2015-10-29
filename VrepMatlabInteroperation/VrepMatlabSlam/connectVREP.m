function [vrep,clientID] = connectVREP(ip,port)
    vrep=remApi('remoteApi');
    vrep.simxFinish(-1);
    clientID=vrep.simxStart(ip,port,true,true,5000,5);
end