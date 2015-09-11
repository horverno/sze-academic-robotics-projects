using System;
using System.Collections.Generic;
using System.Linq;

namespace remoteApiNETWrapper
{
    public static class VREPHelper
    {
        private static bool positionControlEnabled = false;

        public static float D { get; set; }

        public static float I { get; set; }

        public static float P { get; set; }

        public static void BeginSetBlock(int clientID)
        {
            VREPWrapper.simxPauseCommunication(clientID, 1);
        }

        public static void EndSetBlock(int clientID)
        {
            VREPWrapper.simxPauseCommunication(clientID, 0);
        }

        public static simx_error SetJointPositionControl(int clientID, int jointID, bool onOff)
        {
            if (positionControlEnabled == onOff) return simx_error.noerror;
            var code = new List<simx_error>
                           {
                               VREPWrapper.simxSetObjectIntParameter(clientID, jointID, 2001, (onOff) ? 1 : 0, simx_opmode.oneshot_wait),
                               VREPWrapper.simxSetObjectFloatParameter(clientID, jointID, 2002, P, simx_opmode.oneshot),
                               VREPWrapper.simxSetObjectFloatParameter(clientID, jointID, 2003, I, simx_opmode.oneshot),
                               VREPWrapper.simxSetObjectFloatParameter(clientID, jointID, 2004, D, simx_opmode.oneshot)
                           };

            foreach (var c in code.Where(p => p > simx_error.noerror).Select((p, i) => new { Code = p, Index = i }))
            {
                Console.WriteLine("Errors: {0}: {1} -> {2}", jointID, c.Index, c.Code);
            }

            positionControlEnabled = onOff;

            return code.Max();
        }
    }

    public class VREPException : Exception
    {
        private simx_error error;

        public VREPException(simx_error Error, string Message = "")
            : base(String.Format("{0}: {1}", Enum.GetName(typeof(simx_error), Error), Message))
        {
        }
    }
}