function slamGui

%  Create and then hide the GUI as it is being constructed.
f = figure('Visible','off','Position',[360,500,450,285],'NumberTitle','off');
% Make the GUI larger
set(gcf, 'units','normalized','outerposition',[0 0 0.8 0.8]); 
neoOri = 0;
%  Construct the components.
FwdButton = uicontrol('Style','pushbutton','String','Fwd',  'Position',[315,250,70,25],'Callback',{@FwdButton_Callback});
BckButton = uicontrol('Style','pushbutton','String','Bck',  'Position',[315,220,70,25],'Callback',{@BckButton_Callback});
LftButton = uicontrol('Style','pushbutton','String','Left', 'Position',[315,190,70,25],'Callback',{@LftButton_Callback});
RghButton = uicontrol('Style','pushbutton','String','Right','Position',[315,160,70,25],'Callback',{@RghButton_Callback});      
StpButton = uicontrol('Style','pushbutton','String','Stop', 'Position',[315,130,70,25],'Callback',{@StpButton_Callback});
RstButton = uicontrol('Style','pushbutton','String','Reset','Position',[315,100,70,25],'Callback',{@RstButton_Callback});
TxtOri = uicontrol('Style','edit','String',sprintf('\n'),   'Position',[315, 70,70,25],'Max', 4);
ExtButton = uicontrol('Style','pushbutton','String','Exit', 'Position',[315, 50,70,15],'Callback',{@ExtButton_Callback});

global RobotPathLayer EmptyLayer WallLayer laserScan xW yW neoPose p poseAndTimeUnitTest

ha = axes('Units','Pixels','Position',[50,60,200,185]); 
align([FwdButton,BckButton,LftButton,RghButton,StpButton,RstButton,TxtOri],'Center','None');



% Create the data to plot.
mapSize = 640; % the size of the map
mapZoom = 50;  % the zoom factor 
WallLayer = zeros(mapSize,mapSize);
EmptyLayer = zeros(mapSize,mapSize);
RobotPathLayer = zeros(mapSize,mapSize);
neoPose = struct('x', 0, 'y', 0, 'theta', 0); % contains the position and orientation of neobotix
laserScan = 0;
myColorMap = ([1, 1, 1; jet; zeros(35, 3)]); % the color map for display

%% Initialize the GUI.
% Change units to normalized so components resize automatically.
set([f,ha,FwdButton,BckButton,LftButton,RghButton,StpButton,RstButton,TxtOri,ExtButton],'Units','normalized');
%Create a plot in the axes.
image(WallLayer);
% Assign the GUI a name to appear in the window title.
set(f,'Name','slam gui','NumberTitle','off')
% Move the GUI to the center of the screen.
movegui(f,'center')
% Make the GUI visible.
set(f,'Visible','on');

% Connect to V-REP (if not already connected)
if(exist('vrep','var') == 0)
    [vrep, clientID] = connectVREP('127.0.0.1',19997);
end
[~,motorLeft] = vrep.simxGetObjectHandle(clientID, 'wheel_left#0', vrep.simx_opmode_oneshot_wait);
[~,motorRight] = vrep.simxGetObjectHandle(clientID, 'wheel_right#0', vrep.simx_opmode_oneshot_wait);
[~,sickHandle] = vrep.simxGetObjectHandle(clientID, 'SICK_S300_fast#0', vrep.simx_opmode_oneshot_wait);
[~,neoHandle0] = vrep.simxGetObjectHandle(clientID, 'neobotix#0', vrep.simx_opmode_oneshot_wait);
[~,origoHandle] = vrep.simxGetObjectHandle(clientID, 'origo', vrep.simx_opmode_oneshot_wait);
% Initailize the timer
tic
% Initialize the main figure
DrawAllLayer()

%% Push button callbacks

function FwdButton_Callback(~,~) 
  SetWheelSpeedToTarget(2,2,4);
end

function BckButton_Callback(~,~) 
  SetWheelSpeedToTarget(-2,-2, 8);
end

function LftButton_Callback(~,~)
  SetWheelSpeedToTarget(-0.5,0.5,25);
end 

function RghButton_Callback(~,~)
  SetWheelSpeedToTarget(0.5,-0.5,25);
end 

function StpButton_Callback(~,~)
  SetWheelSpeed(0,0);
end

function RstButton_Callback(~,~)
  WallLayer = zeros(mapSize,mapSize);
  EmptyLayer = zeros(mapSize,mapSize);
  RobotPathLayer = zeros(mapSize,mapSize);
  DrawAllLayer()
end

function ExtButton_Callback(~,~)
  disconnectVREP(vrep, clientID);
  close(f);
end

%% Nested functions
function SetWheelSpeed(left, right)
  DrawAllLayer()
  vrep.simxSetJointTargetVelocity(clientID, motorLeft, left, vrep.simx_opmode_oneshot_wait);
  vrep.simxSetJointTargetVelocity(clientID, motorRight, right, vrep.simx_opmode_oneshot_wait);
end

function SetWheelSpeedToTarget(left, right, targetAngle)
  SetWheelSpeed(left, right) % start the robot
  i = 0;
  pos = 0;
  turns = 0;
  maxIteration = 50;
  %targetAngle = 8;
  prevPos = [0 0]; % contains the actual (2) and the previous position of the wheel (1) 
  while (abs(turns*pi*2+pos) < abs(targetAngle) && i < maxIteration) % the robot moves until it reaches the target
       [~, pos] = vrep.simxGetJointPosition(clientID, motorRight, vrep.simx_opmode_oneshot_wait); 
       i = i + 1;
       prevPos(1) = prevPos(2);
       prevPos(2) = pos;
       if prevPos(1) > 0 && prevPos(2) < 0 % if the wheel reaches the  
           turns = turns + 1;
           DrawAllLayer()
           GetPose();
           poseAndTimeUnitTest = [poseAndTimeUnitTest; neoPose.x,neoPose.y,neoPose.theta, currentTime];
       end
  end
  SetWheelSpeed(0, 0) % stop the robot
end

function GetPose()
  [~,neoPos] = vrep.simxGetObjectPosition(clientID, sickHandle, origoHandle, vrep.simx_opmode_oneshot_wait);
  [~,neoOri] = vrep.simxGetObjectOrientation(clientID, neoHandle0, origoHandle, vrep.simx_opmode_oneshot_wait);
  x = int64((neoPos(1)+11)*mapZoom); % convert neoPos to matrix element
  y = int64((neoPos(2)+1)*mapZoom); % convert neoPos to matrix element
  % convert neoOrientaion 
  if neoOri(1) < 0
    neoOri(2) = neoOri(2) * - 1 + pi/2; 
  else
    neoOri(2) = neoOri(2) + pi + pi/2;
  end
  neoPose.x = x;
  neoPose.y = y;
  neoPose.theta = neoOri(2);
  currentTime = toc;
  set(TxtOri, 'String', sprintf('x:%d\ny:%d\ntheta:%.3f\nTime:%.3f', x, y, neoPose.theta, currentTime));
end

function GetLaserScannerData()
  res = 19;
  while (res~=vrep.simx_return_ok)
    [res,laserScan]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
  end
  laserScan = vrep.simxUnpackFloats(laserScan);
  laserScan = reshape(laserScan,3,size(laserScan,2)/3);
  if size(laserScan,2) > 684 % todo
    laserScan = laserScan(:,end-684:end);
    laserScan = [laserScan(1,:) ; (laserScan(2,:) .* -1); (laserScan(3,:))]; % flip laser scanner data
    %plot(laserScan(1,:), laserScan(2,:), 'ro')
    FilterLaserScanner();    
  end
end

function AddRobotToLayer()
  GetPose();
  for n = 1:10
      xD = neoPose.x + int64(n*cos(neoPose.theta));
      yD = neoPose.y + int64(n*sin(neoPose.theta));
      if (xD < mapSize && yD < mapSize && xD > 0 && yD > 0) % if they fit into the matrix
        RobotPathLayer(xD, yD) = 60;
      end
  end
  RobotPathLayer(neoPose.x,neoPose.y) = 100;
end

function AddWallToLayer()
  GetPose();
  GetLaserScannerData();
  laserScan = [cos(neoPose.theta),-sin(neoPose.theta),0;sin(neoPose.theta),cos(neoPose.theta),0;0,0,1] * laserScan; % rotate laser scanner data (orientation)
  if size(laserScan,2) > 684 % todo
   for i = 1:size(laserScan, 2)
    xW = neoPose.x + int64(mapZoom*laserScan(1, i));
    yW = neoPose.y + int64(mapZoom*laserScan(2, i));   
    if (xW < mapSize && yW < mapSize && xW > 0 && yW > 0) % if they fit into the map
      WallLayer(xW, yW) = 40;
    end
    %laserScan(1,i)
   end
  end
end

function AddEmptyToLayer()
  %GetPose();
  %GetLaserScannerData();
  if size(laserScan,2) > 684 % todo
   for i = 1:size(laserScan, 2)
    xW = neoPose.x + int64(mapZoom*laserScan(1, i));
    yW = neoPose.y + int64(mapZoom*laserScan(2, i));
    p = CalcLine(double(xW), double(yW), double(neoPose.x), double(neoPose.y)); 
    for j = 1:size(p, 1)
      if (p(j, 1) < mapSize && p(j, 2) < mapSize && p(j, 1) > 0 && p(j, 2) > 0) % if they fit into the map
        EmptyLayer(p(j, 1), p(j, 2)) = 25;
      end
    end
   end
  end  
end

function points = CalcLine(x1, y1, x2, y2) % Calculates the laser beam lines
    % bresenham algorithm
    x1=round(x1); x2=round(x2);
    y1=round(y1); y2=round(y2);
    dx=abs(x2-x1);
    dy=abs(y2-y1);
    steep=abs(dy)>abs(dx);
    if steep t=dx;dx=dy;dy=t; end
    %The main algorithm goes here.
    if dy==0 
        q=zeros(dx+1,1);
    else
        q=[0;diff(mod([floor(dx/2):-dy:-dy*dx+floor(dx/2)]',dx))>=0];
    end

    %and ends here.
    if steep
        if y1<=y2 y=[y1:y2]'; else y=[y1:-1:y2]'; end
        if x1<=x2 x=x1+cumsum(q);else x=x1-cumsum(q); end
    else
        if x1<=x2 x=[x1:x2]'; else x=[x1:-1:x2]'; end
        if y1<=y2 y=y1+cumsum(q);else y=y1-cumsum(q); end
    end
    points = [x y];
    points = points(4:end, 1:end); % exclude the wall itself
end

function DrawAllLayer()
    AddWallToLayer()      
    %AddRobotToLayer()  
    %AddEmptyToLayer()
    colormap(myColorMap)
    image(RobotPathLayer /3 + WallLayer * 1.5 + EmptyLayer);
    h = zoom;
    set(h,'Motion','both','Enable','on');
    colorbar
end

function FilterLaserScanner()
    % filtering the own contour of the robot from the laser scanner measurement
    filteredLaser = [;]; 
    for n = 1:size(laserScan, 2)
        if ~(abs(laserScan(1,n)) < 0.3 & abs(laserScan(2,n)) < 0.3)
            filteredLaser(1,n) = laserScan(1,n);
            filteredLaser(2,n) = laserScan(2,n); 
            filteredLaser(3,n) = laserScan(3,n);
        else
            filteredLaser(1,n) = NaN;
            filteredLaser(2,n) = NaN; 
            filteredLaser(3,n) = NaN;            
        end
    end
    laserScan = filteredLaser;
end

end

