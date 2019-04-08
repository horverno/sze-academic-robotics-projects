%% Find main lines on ISOC algorithm
%  Coverage path planning algorithm (CPP) on grid map - Iterative structured orientation coverage (ISOC)
%
% Requirements: - 2015b or newer MATLAB
%               - Parallel Computing Toolbox
%               - Image Processing Toolbox
% Copyright (c) Erno Horvath (www.sze.hu/~herno | https://www.linkedin.com/in/herno | github.com/horverno)
%

%% Probabilistic Roadmap (PRM) path planner
function [path] = IsocProbRoadmap(mapUnderTest, startLocation, endLocation)
map = robotics.BinaryOccupancyGrid(mapUnderTest);
prm = robotics.PRM % PRM object, Probabilistic Roadmap
prm.Map = map; % Assign the map to the PRM object
%
prm.NumNodes = 280; % Set the NumNodes properties, how many nodes to be randomly select, this will be increased later
prm.ConnectionDistance = 100; % Set the |ConnectionDistance| properties
% Search for a solution between start and end location. For complex maps,
% there may not be a feasible path for a given number of nodes (returns an empty path).
path = findpath(prm, startLocation, endLocation);

% Since you are planning a path on a large and complicated map, larger
% number of nodes may be required. However, often it is not clear how many
% nodes will be sufficient. Tune the number of nodes to make sure
% there is a feasible path between the start and end location.
while isempty(path)
    % No feasible path found yet, increase the number of nodes
    prm.NumNodes = prm.NumNodes + 10;
    update(prm); % Use the |update| function to re-create the PRM roadmap with the changed attribute
    path = findpath(prm, startLocation, endLocation); % Search for a feasible path with the updated PRM
    %pause(0.01)
end

% hold on
% plot(path(:,1), path(:,2), '*-', 'LineWidth', 4)
% figure
% hold on
% show(prm);
% hold on
% plot(path(:,1), path(:,2), '*-', 'LineWidth', 4)
% Display PRM solution
end

