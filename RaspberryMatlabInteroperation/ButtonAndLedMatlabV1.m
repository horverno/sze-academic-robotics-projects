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
    ip = '192.168.1.2'; % '192.168.1.105' % 'raspberrypi.local'
    % dos(['ping ', ip, ' -c 2']); % ping to verify connection
    mypi = raspi(ip, 'pi', 'raspberry');
  
else
    disp('You are probably already connected!');

end

%% Make the LED "blink" for 10 seconds.

writeDigitalPin(mypi, 4,  1); % white
writeDigitalPin(mypi, 17, 1); % red
writeDigitalPin(mypi, 27, 1); % green
writeDigitalPin(mypi, 22, 1); % blue

for i = 1:10
    writeDigitalPin(mypi, 4, 1);
    pause(0.5);
    writeDigitalPin(mypi, 4, 0);
    pause(0.5);
    fprintf('%d ', i);
end

%% Push button Controlled LED
% Blink the LED rapidly for 1 second whenever the push button is pressed.
fprintf('\n');
for i = 1:50
    buttonPressed1 = readDigitalPin(mypi, 26);
    buttonPressed2 = readDigitalPin(mypi, 13);
    if buttonPressed1
        writeDigitalPin(mypi, 22, 0);
    else
        writeDigitalPin(mypi, 22, 1);
    end
    if buttonPressed2
        writeDigitalPin(mypi, 4, 0);
    else
        writeDigitalPin(mypi, 4, 1);
    end
    pause(0.15);
    fprintf('%d ', i);
end