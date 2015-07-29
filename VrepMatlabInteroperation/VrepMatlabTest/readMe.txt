Make sure you have following files in your directory, in order to run the simpleTest example:

1. remApi.m
2. remoteApiProto.m
3. the appropriate remote API library: "remoteApi.dll" (Windows), "remoteApi.dylib" (Mac) or "remoteApi.so" (Linux)
4. simpleTest.m

-------------------------------------------------------------------

If you choose not to use the prototype file ("remoteApiProto.m"), then you will have to make sure you have a compiler
set-up for Matlab (mex -setup). You will also need "extApi.h" in this folder, and you will have to instanciate the
remote API with "vrep=remApi('remoteApi','extApi.h');" instead of "vrep=remApi('remoteApi');"

Finally, if you wish to rebuild the prototype file, you will have to comply with above conditions, then type:

loadlibrary('remoteApi','extApi.h','mfilename','remoteApiProto')