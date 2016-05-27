%% Szenergy test
%% Connect to V-REP (if not already connected)
if(exist('vrep','var') == 0)
    [vrep, clientID] = connectVREP('127.0.0.1',19997);
end

%% Settings
close all
set(0,'defaultfigurecolor',[1 1 1]);
Res = [];
Data = [];
neoEndTheta = pi / 2;

%% Generate measurement poses and display them
MaxAngleOfView = pi / 2 * 3;
AngleNumber = 6;

FirstRing = 1.5;
LastRing = 4.5; % 4 is the laser scanner measurement distance minust the vehicle
RingNumber = 6;

OrinetationNumber = 1;
HeightNumber = 1;

NumberOfMeasurement = AngleNumber * RingNumber * OrinetationNumber * HeightNumber;
Distances = linspace(FirstRing, LastRing, RingNumber);
Angles = linspace(-1 * MaxAngleOfView / 2, MaxAngleOfView / 2, AngleNumber);
MeasurementPoints = zeros(2, RingNumber * AngleNumber);

k = 1;
for i = 1:RingNumber
for j = 1:AngleNumber
    MeasurementPoints(1, k) = sin(Angles(j)) * Distances(i);
    MeasurementPoints(2, k) = cos(Angles(j)) * Distances(i);
    k = k + 1;
end
end
plot(MeasurementPoints(1, :), MeasurementPoints(2, :), '*');


%% Ask if generated measurement poses applied to V-REP or not
str = input('Get data from V-REP? y/n (empty means no): ', 's');
if isempty(str)
    str = 'n';
end

%% Get the position and orientation of the laser scanner (LIDAR) which is SICK s300 in our case (if answer is yes)
if str == 'y'
    [~, SickHandle] = vrep.simxGetObjectHandle(clientID, 'SICK_S300_fast#0', vrep.simx_opmode_oneshot_wait);
    [~, SickPos] = vrep.simxGetObjectPosition(clientID, SickHandle, -1, vrep.simx_opmode_oneshot_wait);
    [~, SickOri] = vrep.simxGetObjectOrientation(clientID, SickHandle, -1, vrep.simx_opmode_oneshot_wait);
end

%% Apply poses to V-REP and get sick data (if answer is yes)
if str == 'y'
    [~, SzenergyCar] = vrep.simxGetObjectHandle(clientID,'SzenergyCar',vrep.simx_opmode_oneshot_wait);
    [~, SzenergyPos] = vrep.simxGetObjectPosition(clientID,SzenergyCar,-1,vrep.simx_opmode_oneshot_wait);
    [~, SzenergyOri] = vrep.simxGetObjectOrientation(clientID,SzenergyCar,-1,vrep.simx_opmode_oneshot_wait);
    
    Db(1).Meas = zeros(2,4);
    Db(1).RelPos = struct('X', 0, 'Y', 0, 'Z', 0);
    Db(1).RelOri = struct('Alpha', 0, 'Beta', 0, 'Gamma', 0);
    Db(1).Noise = logical(false);
    Db(2:NumberOfMeasurement) = Db(1);
    
    for k = 1:size(MeasurementPoints, 2) % or AngleNumber * RingNumber
        vrep.simxSetObjectPosition(clientID, SzenergyCar, -1, [MeasurementPoints(1, k) + SickPos(1) MeasurementPoints(2, k) + SickPos(2) SickPos(3)],vrep.simx_opmode_oneshot_wait);
        Res = 19;
        %for i = 1:2 % tow times because of streaming operational mode % todo
            while (Res~=vrep.simx_return_ok)
                [Res,Data]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
            end
        %end
        if isempty(Data)
            disp('No LIDAR measurement in the simxReadStringStream. Is your simulation running?');
        else
            Data = vrep.simxUnpackFloats(Data);
            Data = reshape(Data,3,size(Data,2)/3);
            if size(Data, 2) > 684
                Data = Data(:,end-684:end);
            end
            Data = Data(1:2,:); % only the x and y positions are needed
            Data = [Data(1, :); Data(2, :) * -1]; % flip according y (todo: don't understand why it is fliped at the first place)
            Data = [cos(neoEndTheta(1)),-sin(neoEndTheta(1));sin(neoEndTheta(1)),cos(neoEndTheta(1))]*Data;
            Db(k).Meas = Data;
            Db(k).RelPos.X = MeasurementPoints(1, k);
            Db(k).RelPos.Y = MeasurementPoints(2, k);

        end
    end
    
end

%% Ask if display
str = input('Display data? y/n (empty means no): ', 's');
if isempty(str)
    str = 'n';
end

if str == 'y'
    fig1 = figure('Name', 'Laser scanner', 'units','normalized','position',[.1 .1 .4 .4], 'Color',[1 1 1], 'outerposition',[0 0 1 1]);
    for k = 1:size(Db,2)
        Color  = rand(1,3);
        hold on
        plot(Db(k).Meas(1,:), Db(k).Meas(2,:), '-o', 'Color', Color/4, 'MarkerFaceColor', Color, 'MarkerEdgeColor', Color, 'MarkerSize', 10, 'LineSmoothing','on')
        plot(Db(k).RelPos.X , Db(k).RelPos.Y, 'o', 'MarkerFaceColor', Color, 'MarkerEdgeColor', Color, 'MarkerSize', 20, 'LineSmoothing','on');
        pause(1);
    end
end
