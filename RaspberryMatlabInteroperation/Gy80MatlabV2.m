% This MATLAB script is based on the python scripts (The python scripts are also in this repository)
% This script connets to a Raspberry Pi and reads the sensor data of a Gy80 IMU
% The Gy80 IMU (inertial measurement unit) consists of an accelerometer, a gyro a, magnetometer, a barometer and a thermometer
% Erno Horvath (www.sze.hu/~herno | https://www.linkedin.com/in/herno | github.com/horverno)

%% Connection
%Replace with own username and password
if(~exist('mypi','var'))
    ip = '192.168.1.2'; % '192.168.1.105' % 'raspberrypi.local'
    % dos(['ping ', ip, ' -c 2']); % ping to verify connection
    mypi = raspi(ip, 'pi', 'raspberry');
    
    if (strcmp(mypi.AvailableI2CBuses, 'i2c-1'))
        i2CBuses = scanI2CBus(mypi,'i2c-1')
    end

    % GY80 consists of:
    % 3 Axis Gyro	ST Microelectronics L3G4200D        0x69
    % 3 Axis Accelerometer	Analog Devices ADXL345      0x53
    % 3 Axis Magnetometer	Honeywell MC5883L           0x1E
    % Barometer + Thermometer	Bosch BMP085            0x77

    addressGyroL3G4200D = hex2dec('69');
    addressAccelAdxl345 = hex2dec('53');
    addressMagMC5883L = hex2dec('1E');
    addressThermoBarBMP085 = hex2dec('77');
    
    gyroSensor = i2cdev(mypi,'i2c-1', addressGyroL3G4200D)
    magnetoSensor = i2cdev(mypi,'i2c-1', addressMagMC5883L)
    accelSensor = i2cdev(mypi,'i2c-1', addressAccelAdxl345)
   
else
    disp('You are probably already connected!');

end

%% IMU

xMag = [], yMag = []; zMag = [];
bearingMag = 0;

writeRegister(gyroSensor, hex2dec('20') , hex2dec('0F'),'uint8')
xGy = []; yGy = []; zGy = [];

xA = []; yA = []; zA = [];

if read(accelSensor, 1) == hex2dec('e5')
    % Enable the accelerometer
    writeRegister(accelSensor, hex2dec('2d'), hex2dec('08'), 'uint8');
end
figure
subplot(2, 2, 1)

for i = 1:100
    writeRegister(magnetoSensor, hex2dec('0') , bi2de([0 1 1 1 0 0 0 0], 'left-msb'), 'uint8')
    writeRegister(magnetoSensor, hex2dec('1') , bi2de([0 0 1 0 0 0 0 0], 'left-msb'), 'uint8')
    writeRegister(magnetoSensor, hex2dec('2') , bi2de([0 0 0 0 0 0 0 0], 'left-msb'), 'uint8')
    scaleMag = 0.92;

    xM = double(readRegister(magnetoSensor, 3, 'uint16')) * scaleMag; % python: x_out = read_word_2c(3) * scale
    yM = double(readRegister(magnetoSensor, 7, 'uint16')) * scaleMag;
    zM = double(readRegister(magnetoSensor, 5, 'uint16')) * scaleMag;
    bearingMag  = atan2(yM, xM);
    if bearingMag < 0
        bearingMag = bearingMag + 2 * pi;
    end
    fprintf('Bearing: %f x: %d y: %d z: %d\n', rad2deg(bearingMag), xM, yM, zM)
    xMag = [xMag; xM];
    yMag = [yMag; yM];
    zMag = [zMag; zM];
    subplot(2, 2, 1)
    plot([xMag yMag zMag])
    legend('x mag', 'y mag', 'z mag')
    
    h2 = subplot(2, 2, 2)
    cla(h2)
    compass(cos(bearingMag),sin(bearingMag))
    
    
    write(gyroSensor, hex2dec('28')) % python: i2c_bus.write_byte(i2c_address,0x28)
    xL = read(gyroSensor, 1);        % python: i2c_bus.read_byte(i2c_address)
    write(gyroSensor, hex2dec('29')) 
    xR = read(gyroSensor, 1);
    xGy = [xGy; typecast(uint8([xL xR]), 'uint16')];
    
    write(gyroSensor, hex2dec('2A')) 
    yL = read(gyroSensor, 1); 
    write(gyroSensor, hex2dec('2B')) 
    yR = read(gyroSensor, 1);
    yGy = [yGy; typecast(uint8([yL yR]), 'uint16')];
    
    write(gyroSensor, hex2dec('2C')) 
    zL = read(gyroSensor, 1); 
    write(gyroSensor, hex2dec('2D')) 
    zR = read(gyroSensor, 1);
    zGy = [zGy; typecast(uint8([zL zR]), 'uint16')];
    
    % hold on
    subplot(2, 2, 3)
    plot([xGy yGy zGy])
    legend('x gyro', 'y gyro', 'z gyro')
    
        rawAcc = readRegister(accelSensor, hex2dec('32'),'uint64'); % python: raw = self.accel.readList(self.ADXL345_REG_DATAX0, 6)
    resAcc = typecast(rawAcc, 'uint8');
    xAcc = resAcc(1);
    if typecast([resAcc(1) resAcc(2)], 'uint16') > 32767
        xAcc = int8(typecast([resAcc(1) resAcc(2)], 'uint16')) - 65536; end
    yAcc = resAcc(3);
    if typecast([resAcc(3) resAcc(4)], 'uint16') > 32767
        yAcc = int8(typecast([resAcc(3) resAcc(4)], 'uint16')) - 65536; end
    zAcc = resAcc(5);
    if typecast([resAcc(5) resAcc(6)], 'uint16') > 32767
        zAcc = int8(typecast([resAcc(5) resAcc(6)], 'uint16')) - 65536; end
    
    xA = [xA; xAcc];
    yA = [yA; yAcc];
    zA = [zA; zAcc];
    subplot(2, 2, 4)
    plot([xA yA zA])
    legend('x acc', 'y acc', 'z acc')
    
    pause(0.1)
end


