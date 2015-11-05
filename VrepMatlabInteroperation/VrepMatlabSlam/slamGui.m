function slamGui

%  Create and then hide the GUI as it is being constructed.
f = figure('Visible','off','Position',[360,500,450,285]);
neoOri = 0;
%  Construct the components.
FwdButton = uicontrol('Style','pushbutton','String','Fwd',  'Position',[315,250,70,25],'Callback',{@FwdButton_Callback});
BckButton = uicontrol('Style','pushbutton','String','Bck',  'Position',[315,220,70,25],'Callback',{@BckButton_Callback});
LftButton = uicontrol('Style','pushbutton','String','Left', 'Position',[315,190,70,25],'Callback',{@LftButton_Callback});
RghButton = uicontrol('Style','pushbutton','String','Right','Position',[315,160,70,25],'Callback',{@RghButton_Callback});      
StpButton = uicontrol('Style','pushbutton','String','Stop', 'Position',[315,130,70,25],'Callback',{@StpButton_Callback});
RstButton = uicontrol('Style','pushbutton','String','Reset','Position',[315,100,70,25],'Callback',{@RstButton_Callback});
TxtOri = uicontrol('Style','edit','String',num2str(neoOri), 'Position',[315, 70,70,25]);

global RobotPathLayer laserScan xW yW neoPose

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

%% Initialize the GUI.
% Change units to normalized so components resize automatically.
set([f,ha,FwdButton,BckButton,LftButton,RghButton,StpButton,RstButton,TxtOri],'Units','normalized');
%Create a plot in the axes.
image(WallLayer);
% Assign the GUI a name to appear in the window title.
set(f,'Name','slam gui')
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
%% Push button callbacks

function FwdButton_Callback(~,~) 
  DrawRobot();
  DrawWall();
  SetWheelSpeed(2,2);
end

function BckButton_Callback(~,~) 
  image(RobotPathLayer); 
  SetWheelSpeed(-2,-2);
end

function LftButton_Callback(~,~) 
  SetWheelSpeed(-2,2);
  DrawWall();
end 

function RghButton_Callback(~,~) 
  SetWheelSpeed(2,-2);
  DrawWall();
end 

function StpButton_Callback(~,~) 
  SetWheelSpeed(0,0);
  DrawWall();
  %DrawRobot();
end

function RstButton_Callback(~,~)
  WallLayer = zeros(mapSize,mapSize);
  EmptyLayer = zeros(mapSize,mapSize);
  RobotPathLayer = zeros(mapSize,mapSize);
  image(RobotPathLayer);
end

%% Nested functions
function SetWheelSpeed(left, right)
  vrep.simxSetJointTargetVelocity(clientID, motorLeft, left, vrep.simx_opmode_oneshot_wait);
  vrep.simxSetJointTargetVelocity(clientID, motorRight, right, vrep.simx_opmode_oneshot_wait);
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
  set(TxtOri, 'String', num2str(neoPose.theta));
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

function DrawRobot()
  GetPose();
  for n = 1:10
      xD = neoPose.x + int64(n*cos(neoPose.theta));
      yD = neoPose.y + int64(n*sin(neoPose.theta));
      if (xD < mapSize && yD < mapSize && xD > 0 && yD > 0) % if they fit into the matrix
        RobotPathLayer(xD, yD) = 60;
      end
  end
  RobotPathLayer(neoPose.x,neoPose.y) = 100;
  image(RobotPathLayer);
end

function DrawWall()
  GetPose();
  GetLaserScannerData();
  laserScan = [cos(neoPose.theta),-sin(neoPose.theta),0;sin(neoPose.theta),cos(neoPose.theta),0;0,0,1] * laserScan; % rotate laser scanner data (orientation)
  if size(laserScan,2) > 684 % todo
   for i = 1:size(laserScan, 2)
    xW = neoPose.x + int64(mapZoom*laserScan(1, i));
    yW = neoPose.y + int64(mapZoom*laserScan(2, i));   
    if (xW < mapSize && yW < mapSize && xW > 0 && yW > 0) % if they fit into the map
      RobotPathLayer(xW, yW) = 40;
    end
    %laserScan(1,i)
   end
  end
  image(RobotPathLayer);
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

