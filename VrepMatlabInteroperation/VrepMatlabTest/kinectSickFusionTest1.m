%% Kinect + Laser scanner (sick s300) fusion test from Vrep
%% Connect to V-REP (if not already connected)
if(exist('vrep','var') == 0)
    [vrep, clientID] = connectVREP('127.0.0.1',19997);
end
%%
[err,left]=vrep.simxGetObjectHandle(clientID,'wheel_left#0',vrep.simx_opmode_oneshot_wait);
vrep.simxSetJointTargetPosition(clientID,left,2*pi,vrep.simx_opmode_oneshot_wait);

%% Get kinect depth data
[err, kinect_depth] = vrep.simxGetObjectHandle(clientID, 'kinect_depth#0', vrep.simx_opmode_oneshot_wait);
[retCode, res, depth] = vrep.simxGetVisionSensorDepthBuffer2(0,kinect_depth, vrep.simx_opmode_oneshot_wait);
depth = fliplr(double(depth)); % flip Kinect data
  
%% Get sick data
[err, sick] = vrep.simxGetObjectHandle(clientID,'SICK_S300_fast#0', vrep.simx_opmode_oneshot_wait);
res = 19;

while (res~=vrep.simx_return_ok)
    [res,laser_scan]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
end

data = vrep.simxUnpackFloats(laser_scan);
data = reshape(data,3,size(data,2)/3);
outer_hull = data(:,end-684:end);
outer_hull = outer_hull / 3.42; %
outer_hull = [outer_hull(1,:) ; (outer_hull(2,:) .* -1); (outer_hull(3,:) - 0.17)]; % flip laser scanner data according Y, move down according Z

%% The angles for kinect
delta_z=57*pi/180;
np_z=640;
delta_x=43*pi/180;
np_x=480;
d_delta_z=-delta_z/2:delta_z/(np_z-1):delta_z/2;
d_delta_x=-delta_x/2:delta_x/(np_x-1):delta_x/2;

%% Plot original kinect data
figure('Name', 'Kinect')
daspect([1 1 1])
mesh(depth)

%% Plot original sick data
figure('Name', 'Laser scanner')
daspect([1 1 1])
scatter3(outer_hull(1,:),outer_hull(2,:),outer_hull(3,:))

%% The data base of mesurements
poza_1(:,:,1)=depth;
beta=[270,30,60,90,120,150,180,210,240,270,300,330]*pi/180;

%% Filtering the measurements
    poza=poza_1(:,:,1);%
    poza=double(poza);
    poza(poza==0)=NaN;
    poza = medfilt2(poza,[2 2]);  
    [Dx,Dy]=gradient(poza);
    gradV_abs=sqrt(Dx.^2+Dy.^2);
    poza(gradV_abs > 200) = NaN;
    poza_1(:,:,1)=poza;%

%% The posiions computation
Ry=[cos(-pi),0,sin(-pi);0,1,0;-sin(-pi),0,cos(-pi)];
PPuncte=[];

    figure('Name', 'Fusion')
    Puncte=[];
    poza=poza_1(:,:,1);
    for i=1:5:np_x%
        for j=1:5:np_z%
            y=poza(i,j);
            if isnan(y)
            else
                x=y*tan(d_delta_x(1,i));
                z=y*tan(d_delta_z(1,j));
                punct=[z;y;x];
                Puncte=[Puncte,punct];
            end
        end
    end  
  Puncte=Ry*Puncte;
  Puncte=[cos(beta(1,1)),-sin(beta(1,1)),0;sin(beta(1,1)),cos(beta(1,1)),0;0,0,1]*Puncte;
  PPuncte=[PPuncte,Puncte];
  plot3(Puncte(1,1:1:end),Puncte(2,1:1:end),Puncte(3,1:1:end),'.','Color','b')
  hold on
  set(gca,'DataAspectRatio',[1 1 1])
  xlabel 'X'
  ylabel 'Y'
  zlabel 'Z'
  plot3(outer_hull(1,:),outer_hull(2,:),outer_hull(3,:),'.', 'Color', 'r')
  hold on
  auxK = [cosd( 57/2), 0, cosd( 57/2); sind( 57/2), 0, -sind( 57/2); 0, 0, 0]; % auxiliary lines to Kinect display
  auxS = [cosd(270/2), 0, cosd(270/2); sind(270/2), 0, -sind(270/2); 0, 0, 0]; % auxuilary lines to laser display
  plot3(auxK(1,:),auxK(2,:),auxK(3,:),'-', 'Color', 'g')
  hold on
  plot3(auxS(1,:),auxS(2,:),auxS(3,:),'-', 'Color', 'b')
