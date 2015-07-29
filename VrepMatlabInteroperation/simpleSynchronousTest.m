% Copyright 2006-2015 Coppelia Robotics GmbH. All rights reserved. 
% marc@coppeliarobotics.com
% www.coppeliarobotics.com
% 
% -------------------------------------------------------------------
% THIS FILE IS DISTRIBUTED "AS IS", WITHOUT ANY EXPRESS OR IMPLIED
% WARRANTY. THE USER WILL USE IT AT HIS/HER OWN RISK. THE ORIGINAL
% AUTHORS AND COPPELIA ROBOTICS GMBH WILL NOT BE LIABLE FOR DATA LOSS,
% DAMAGES, LOSS OF PROFITS OR ANY OTHER KIND OF LOSS WHILE USING OR
% MISUSING THIS SOFTWARE.
% 
% You are free to use/modify/distribute this file for whatever purpose!
% -------------------------------------------------------------------
%
% This file was automatically created for V-REP release V3.2.1 on May 3rd 2015

% This small example illustrates how to use the remote API
% synchronous mode. The synchronous mode needs to be
% pre-enabled on the server side. You would do this by
% starting the server (e.g. in a child script) with:
%
% simExtRemoteApiStart(19999,1300,false,true)
%
% But in this example we try to connect on port
% 19997 where there should be a continuous remote API
% server service already running and pre-enabled for
% synchronous mode.
%
% IMPORTANT: for each successful call to simxStart, there
% should be a corresponding call to simxFinish at the end!

function simpleSynchronousTest()
	disp('Program started');
	% vrep=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
	vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
	vrep.simxFinish(-1); % just in case, close all opened connections
	clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5);

	if (clientID>-1)
		disp('Connected to remote API server');

		% enable the synchronous mode on the client:
		vrep.simxSynchronous(clientID,true);

		% start the simulation:
		vrep.simxStartSimulation(clientID,vrep.simx_opmode_oneshot_wait);

		% Now step a few times:
		for i=0:10
			disp('Press a key to step the simulation!');
			pause;
			vrep.simxSynchronousTrigger(clientID);
		end

		% stop the simulation:
		vrep.simxStopSimulation(clientID,vrep.simx_opmode_oneshot_wait);

		% Now close the connection to V-REP:	
		vrep.simxFinish(clientID);
	else
		disp('Failed connecting to remote API server');
	end
	vrep.delete(); % call the destructor!
	
	disp('Program ended');
end
