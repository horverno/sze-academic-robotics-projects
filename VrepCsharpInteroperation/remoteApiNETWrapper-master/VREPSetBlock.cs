using System;

namespace remoteApiNETWrapper
{
    public class VREPSetBlock : IDisposable
    {
        private readonly int clientID;

        public VREPSetBlock(int cID)
        {
            // Console.WriteLine("--- Opening Set Block -----");
            clientID = cID;
            if (VREPWrapper.simxPauseCommunication(cID, 1) != 0) throw new VREPException(simx_error.remote_error_flag, "Pausing communication failed");
        }

        public void Dispose()
        {
            if (VREPWrapper.simxPauseCommunication(clientID, 0) != 0) throw new VREPException(simx_error.remote_error_flag, "Restarting communication failed");
            // Console.WriteLine("--- Set Block closed ------");
        }
    }
}