# Coverage path planning algorithms (CPP) on grid maps

Some grid map (occupancy grid) based coverage path planning algorithms implemented in MATLAB.


## 1. Boustrophedon Cellular Decomposition 
*Name*: `CoveragePathPlanningBoustrophedon.m`
*Description*: The map is decomposed into cells, and each of them is covered by the robot with simple back and forth motions.


## Example
The `CoveragePathPlanningBoustrophedon.m` works as follows.

You can choose from several maps, after you have decided the orignal map will be displayed.
![alt tag](http://www.sze.hu/~herno/robotics/CoveragePathPlanBoustrophedon/Boustrophedon01.png)

The algorithm creates the blobs to find critical points, thus decompose the map into sub-poygons.
![alt tag](http://www.sze.hu/~herno/robotics/CoveragePathPlanBoustrophedon/Boustrophedon02.png)

The algorithm determines the connectivity graph (`cellGraph`).
![alt tag](http://www.sze.hu/~herno/robotics/CoveragePathPlanBoustrophedon/Boustrophedon03.png)

The algorithm determines the motion according in every sub-poligons the connectivity graph (`cellGraph`).
![alt tag](http://www.sze.hu/~herno/robotics/CoveragePathPlanBoustrophedon/Boustrophedon04.png)

The algorithm generates the `digraph` object (directed graph) which is basically the boustrophedon path.
![alt tag](http://www.sze.hu/~herno/robotics/CoveragePathPlanBoustrophedon/Boustrophedon05.png)


## 2. Iterative structured orientation coverage (ISOC)
*Name*: `CoveragePathPlanningIterativeStructuredOrientation.m`
*Description*: Own developed algorithm.


## Example
Later.
