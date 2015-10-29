function slamGui

%  Create and then hide the GUI as it is being constructed.
f = figure('Visible','off','Position',[360,500,450,285]);

%  Construct the components.
FwdButton = uicontrol('Style','pushbutton','String','Fwd',  'Position',[315,250,70,25],'Callback',{@FwdButton_Callback});
BckButton = uicontrol('Style','pushbutton','String','Bck',  'Position',[315,220,70,25],'Callback',{@BckButton_Callback});
LftButton = uicontrol('Style','pushbutton','String','Left', 'Position',[315,190,70,25],'Callback',{@LftButton_Callback});
RghButton = uicontrol('Style','pushbutton','String','Right','Position',[315,160,70,25],'Callback',{@RghButton_Callback});      
StpButton = uicontrol('Style','pushbutton','String','Stop', 'Position',[315,130,70,25],'Callback',{@StpButton_Callback});
RstButton = uicontrol('Style','pushbutton','String','Reset','Position',[315,100,70,25],'Callback',{@RstButton_Callback});

global ha peaks_data

ha = axes('Units','Pixels','Position',[50,60,200,185]); 
align([FwdButton,BckButton,LftButton,RghButton,StpButton,RstButton],'Center','None');



% Create the data to plot.
WallLayer = zeros(1024,1024);
EmptyLayer = zeros(1024,1024);
RobotPathLayer = zeros(1024,1024);

%% Initialize the GUI.
% Change units to normalized so components resize automatically.
set([f,ha,FwdButton,BckButton,LftButton,RghButton,StpButton,RstButton],'Units','normalized');
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
[~,neoHandle0] = vrep.simxGetObjectHandle(clientID, 'neobotix#0', vrep.simx_opmode_oneshot_wait);

%% Push button callbacks

function FwdButton_Callback(~,~) 
  image(WallLayer);
  [~,neoPos] = vrep.simxGetObjectPosition(clientID, neoHandle0, 0, vrep.simx_opmode_oneshot_wait);
  neoPos
  SetWheelSpeed(2,2);
end

function BckButton_Callback(~,~) 
  image(EmptyLayer); 
  SetWheelSpeed(-2,-2);
end

function LftButton_Callback(~,~) 
  image(RobotPathLayer); 
  SetWheelSpeed(-3,3);
end 

function RghButton_Callback(~,~) 
  SetWheelSpeed(2,-2);
end 

function StpButton_Callback(~,~) 
  SetWheelSpeed(0,0);
end

%% Nested functions
function SetWheelSpeed(left, right)
  vrep.simxSetJointTargetVelocity(clientID, motorLeft, left, vrep.simx_opmode_oneshot_wait);
  vrep.simxSetJointTargetVelocity(clientID, motorRight, right, vrep.simx_opmode_oneshot_wait);
end

end

