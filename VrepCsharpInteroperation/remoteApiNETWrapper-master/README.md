remoteApiNETWrapper
===================

C#/.NET wrapper DLL for Coppelia Robotics V-REP simulator remote API

The purpose of this project is to give the gentle developer a wrapper DLL for writing V-REP remote API clients in a Microsoft .NET language like C# or Visual Basic .NET.

In the current version, the list of provided functions is highly incomplete. More functions will get added when I - the creator of the project - need them. 

If someone needs to add a function just take a look on how they are connected using P/Invoke and the [DllImport] attribute and feel free to add more. I'll happily integrate any function added by helping hands. 

Usage: just add the DLL as reference and put the remoteAPI.dll into the output folder (where your executable is created/can find it). That should do it. 
