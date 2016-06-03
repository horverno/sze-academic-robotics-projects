%% Szenergy test
%% Connect to V-REP (if not already connected)
if(exist('vrep','var') == 0)
    [vrep, clientID] = connectVREP('127.0.0.1',19997);
    % First read LIDAR in streaming mode (second buffer)
    [~,~]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_streaming);
end

%% Settings
close all
set(0,'defaultfigurecolor',[1 1 1]);
Res = [];
Data = [];
neoEndTheta = pi / 2;

%% Generate measurement poses and display them
AngleNumber = 6;
MaxAngleOfView = pi / 5 * 6;

RingNumber = 2;
FirstRing = 1.8;
LastRing = 4.5; % 4.5 is the laser scanner measurement distance minus the vehicle itself

HeightNumber = 2;
HeightDistance = 0.2; % The absolute Z axis distance up and down 

OrinetationNumber = 3;
MaxAngleOfOrinetation = pi / 32;

NumberOfMeasurement = AngleNumber * RingNumber * OrinetationNumber * HeightNumber;
Angles = linspace(-1 * MaxAngleOfView / 2, MaxAngleOfView / 2, AngleNumber);
Distances = linspace(FirstRing, LastRing, RingNumber);
Heights = linspace(-HeightDistance/2, HeightDistance/2, HeightNumber);
Orinetations = linspace(-1 * MaxAngleOfOrinetation / 2, MaxAngleOfOrinetation / 2, OrinetationNumber);

MeasurementPoints = zeros(4, RingNumber * AngleNumber * HeightNumber * OrinetationNumber); 
disp(strcat('Number of iteration is:  ', num2str(size(MeasurementPoints, 2))));
x = 1;
for i = 1:RingNumber
    for j = 1:AngleNumber
        for k = 1:HeightNumber
            for l = 1:OrinetationNumber
                MeasurementPoints(1, x) = sin(Angles(j)) * Distances(i); % x
                MeasurementPoints(2, x) = cos(Angles(j)) * Distances(i); % y
                MeasurementPoints(3, x) = Heights(k); % z
                MeasurementPoints(4, x) = Orinetations(l); % orientation
                x = x + 1;
            end
        end
    end
end
% Debug
% MeasurementPoints = [-4 1.2 -1 -3; -4 1.5 0 4];
% NumberOfMeasurement = size(MeasurementPoints, 2);
plot(MeasurementPoints(1, :), MeasurementPoints(2, :), '*');


%% Ask if generated measurement poses applied to V-REP or not
str = input('Get data from V-REP and display randomly selected few of them? y/n (empty means no): ', 's');
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
    
    % Creating the database variable
    Db(1).Meas = zeros(2,4);
    Db(1).RelPos = struct('X', 0, 'Y', 0, 'Z', 0);
    Db(1).RelOri = struct('Alpha', 0, 'Beta', 0, 'Gamma', 0);
    Db(1).Noise = logical(false);
    Db(2:NumberOfMeasurement) = Db(1);
    
    % Applying the generated measurement poses and save it to the database variable
    for x = 1:size(MeasurementPoints, 2) % or ingNumber * AngleNumber * OrinetationNumber * HeightNumber
        vrep.simxSetObjectPosition(clientID, SzenergyCar, -1, [MeasurementPoints(1, x) + SickPos(1) MeasurementPoints(2, x) + SickPos(2) MeasurementPoints(3, x) + SickPos(3)],vrep.simx_opmode_oneshot_wait);
        vrep.simxSetObjectOrientation(clientID, SzenergyCar, -1, [SzenergyOri(1) SzenergyOri(2) + MeasurementPoints(4, x) SzenergyOri(3)],vrep.simx_opmode_oneshot_wait);
        Res = 19;
        pause(1);
        % Read LIDAR in buffer opmode (after the first call which sould be streaming)
        [Res,Data]=vrep.simxReadStringStream(clientID,'measuredDataAtThisTime0', vrep.simx_opmode_buffer );
        if (Res ~= vrep.simx_return_ok)
            disp('ReadStringStream returned error.');
        end
        if isempty(Data)
            disp('No LIDAR measurement in the simxReadStringStream.');
        else
            Data = vrep.simxUnpackFloats(Data);
            Data = reshape(Data,3,size(Data,2)/3);
            if size(Data, 2) > 684
                Data = Data(:,end-684:end);
            end
            Data = Data(1:2,:); % only the x and y positions are needed
            Data = [Data(1, :); Data(2, :) * -1]; % flip according y (todo: don't understand why it is fliped at the first place)
            Data = [cos(neoEndTheta(1)),-sin(neoEndTheta(1));sin(neoEndTheta(1)),cos(neoEndTheta(1))]*Data;
            Db(x).Meas = Data;
            Db(x).RelPos.X = MeasurementPoints(1, x);
            Db(x).RelPos.Y = MeasurementPoints(2, x);
            Db(x).RelPos.Z = MeasurementPoints(3, x);
            Db(x).RelOri.Alpha = MeasurementPoints(4, x);
        end
    end
    
end

%% Display
if str == 'y'
    if size(Db,2) > 500
        disp('Very high number of measurement data, it is saved, but please display it manually');
    else
        fig1 = figure('Name', 'Laser scanner', 'units','normalized','position',[.1 .1 .4 .4], 'Color',[1 1 1], 'outerposition',[0 0 1 1]);
        randomSize = uint16(size(Db, 2) / 10);
        disp(strcat(num2str(randomSize), ' random measurement will be displayed'));
        % Select random measurements according the generated vector
        randomMeas = uint16((size(Db,2)-2).*rand(randomSize,1) + 1);
        for x = 1:size(randomMeas, 1)
            Color  = rand(1,3);
            hold on
            if ~isempty(Db(randomMeas(x)))
                plot(Db(randomMeas(x)).Meas(1,:), Db(randomMeas(x)).Meas(2,:), '-o', 'Color', Color/4, 'MarkerFaceColor', Color, 'MarkerEdgeColor', Color, 'MarkerSize', 10, 'LineSmoothing','on')
                plot(Db(randomMeas(x)).RelPos.X , Db(randomMeas(x)).RelPos.Y, 'o', 'MarkerFaceColor', Color, 'MarkerEdgeColor', Color, 'MarkerSize', 20, 'LineSmoothing','on');            
                pause(1);
            end
        end
    end
end
