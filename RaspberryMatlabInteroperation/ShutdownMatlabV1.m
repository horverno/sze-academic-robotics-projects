%% Usually you can execute sytem commands with simple "system" call
system(mypi,'ls -al')
system(mypi,'hostname -I')

% except shut down

%% Shut down
h = raspberrypi
h.execute('sudo shutdown -h now')