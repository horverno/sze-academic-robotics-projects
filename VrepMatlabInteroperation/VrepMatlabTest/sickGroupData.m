[err, sick] = ...
    vrep.simxGetObjectHandle(0,'SICK_S300_fast',...
    vrep.simx_opmode_oneshot_wait);
res = 19;
while (res~=vrep.simx_return_ok)
    [res,laser_scan]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime',...
        vrep.simx_opmode_streaming);
end
data = vrep.simxUnpackFloats(laser_scan);
data = reshape(data,3,size(data,2)/3);
outer_hull = data(:,end-684:end)
%outer_hull = data(:,1:684)
close all
figure()
scatter3(outer_hull(1,:),outer_hull(2,:),outer_hull(3,:))
figure()
fill(outer_hull(1,:),outer_hull(2,:),'r')