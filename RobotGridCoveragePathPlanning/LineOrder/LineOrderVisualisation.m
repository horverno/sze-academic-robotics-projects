% In order to specify line visiting order (graph traversal) a simple heuristic greedy algorithm is used. 

%% Close all and load the example data set
close all
try
    load('LineGraphData2.mat');
catch
    waitfor(msgbox('Error: .mat file is missing!'));
    return
end
% filename = 'LineOrder.gif'; % gif
% imwrite(imind,cm,filename,'gif', 'Loopcount',inf); % gif

%% Create line node list which conains all the lines
lineNodeList = java.util.ArrayList;
lineNodeList.clear();
for i = 1:lineGraph.numnodes
    lineNodeList.add(num2str(i));
end

plotHandle = plot(lineGraph, 'XData', xCoordOfLines, 'YData', yCoordOfLines, 'MarkerSize', 10, 'LineWidth', 8, 'EdgeColor', 'r', 'NodeColor','r');

%% Specifiy line visiting order (while visiting every line in the lineGraph)
greedyLineOrder = [1];
nextNode = 1;
prevNode = 1;
i = 0;
nodeCount = 1;
while ~lineNodeList.isEmpty && i < 200
    if lineNodeList.contains(num2str(nextNode))
        lineNodeList.remove(num2str(nextNode));
        path = shortestpath(lineGraph, prevNode, nextNode);
        for l = 1:size(path, 2)
            if lineNodeList.contains(num2str(path(l)))
                lineNodeList.remove(num2str(path(l)));               
            end
        end
        highlight(plotHandle, path, 'NodeColor','g','EdgeColor','g')
        pause(1);
        greedyLineOrder = [greedyLineOrder path(2:end)];
    else
        disp('There is no such node.');
    end
    hold on
    highlight(plotHandle, nextNode,'NodeColor','r', 'EdgeColor','r')
    prevNode = nextNode;
    i = i + 1;
    nodeNeighbor = [];
    tmp = neighbors(lineGraph, nextNode);
    for j = 1:size(tmp, 1)
       if lineNodeList.contains(num2str(tmp(j)))
           nodeNeighbor = [nodeNeighbor tmp(j)];
       end
    end
    % If node has 1 neighbor than choose it
    if size(nodeNeighbor) == 1
        nextNode = nodeNeighbor;
        %disp('If node has 1 neighbor than choose it');
    % Else choose another close node
    else
        while ~lineNodeList.contains(num2str(nodeCount)) && i < 200
            nodeCount = nodeCount + 1;
            i = i + 1;
        end
        nextNode = nodeCount;
    end
    % frame = getframe(1); % gif
    % im = frame2im(frame); % gif
    % [imind,cm] = rgb2ind(im,256); % gif
    % imwrite(imind,cm,filename,'gif','WriteMode','append'); % gif
end
disp(greedyLineOrder)