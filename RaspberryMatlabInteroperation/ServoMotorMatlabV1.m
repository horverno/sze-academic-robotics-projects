% This MATLAB script is based on the python scripts (The python scripts are also in this repository)
% This script connets to a Raspberry Pi, blinks LEDs and gets button state
% Erno Horvath (www.sze.hu/~herno | https://www.linkedin.com/in/herno | github.com/horverno)
% MATLAB uses the GPIO.BOARD numbering, the in python you can choose
% between GPIO.BCM and GPIO.BOARD. The table displays the numbering:
% BCM 7     => MATLAB 4
% BCM 11	=> MATLAB 17
% BCM 13	=> MATLAB 27
% BCM 15	=> MATLAB 22
% BCM 29	=> MATLAB 5
% BCM 31	=> MATLAB 6
% BCM 33	=> MATLAB 13
% BCM 37	=> MATLAB 26	


%% Connection
% Replace with own username and password
if(~exist('mypi','var'))
    ip = '192.168.1.101'; % '192.168.1.105' % 'raspberrypi.local'
    % dos(['ping ', ip, ' -c 2']); % ping to verify connection
    mypi = raspi(ip, 'pi', 'raspberry');
  
else
    disp('You are probably already connected!');

end

%% Servo Motor
for i = 1:80
    writeDigitalPin(mypi, 17, 1); % red
    pause(0.001)
    writeDigitalPin(mypi, 17, 0); % red
end

%% For 2016b or later
% writeDigitalPin(mypi, 17, 1); % Sets up pin 11 to an output (instead of an input)
% configurePin(mypi, 17, 'PWM');
% 
% write
% writePWMDutyCycle(mypi, 17, 0.03); % Changes the pulse width to 3 (so moves the servo)
% writePWMFrequency(mypi, 17, 2000);
% 
% pause(1)
% writePWMDutyCycle(mypi, 17, 0.12); % Changes the pulse width to 12 (so moves the servo)
% writePWMFrequency(mypi, 17, 2000);
