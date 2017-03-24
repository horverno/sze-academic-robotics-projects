%% MapInfo
% Copyright (c) Erno Horvath (www.sze.hu/~herno | https://www.linkedin.com/in/herno | github.com/horverno)
%

%% Settings
animate = 1; % play an animation 
generatePng = 1; %genertae png files from the *.mat files by displaying it on figures
myColorBw1 = [0 0 0; 1 1 1];
myColorBw2 = [1 1 1; 0 0 0];

%%
mapList = dir('*.mat');
disp({mapList.name});
for i = 1:size(mapList,1)
    actualMap = load(mapList(i).name);
    %figure
    %image(actualMap.map * 100);
end

%% Animate the images
figAnimate = figure('Color',[1 1 1]);
for i = 1:size(mapList,1)
    if animate || generatePng
        actualMap = load(['Maps\', lower(mapList(i).name)]);
        subplot(1,2,1);
        hold on
        figAnimate = gcf;
        clf(figAnimate, 'reset')
        set(figAnimate, 'Name', ['', num2str(i), '/', num2str(size(mapList,1))], 'NumberTitle','off');
        figAnimate = image(actualMap.map);
        colormap(myColorBw1);
        hcb = colorbar;
        set(hcb, 'YTick',[0 1])
        axis equal
        set(findall(figAnimate,'-property','FontSize'),'FontSize', 16)
        grid on 
        set(gca,'layer','top')
        [~, ~, blobNumber, ~] = bwboundaries(actualMap.map);
        occupancyRatio = 100 - (sum(sum(actualMap.map)) / (size(actualMap.map, 1) * size(actualMap.map, 2)) * 100);
        wA = size(actualMap.map, 1);
        hA = size(actualMap.map, 2);
        title({['Size: ', num2str(wA), 'x', num2str(hA), ' = ',  num2str(wA * hA)], ['Number of holes: ', num2str(blobNumber-1)], ['Occupancy ratio: ', num2str(occupancyRatio), '%']})
        %pause(1);
    end
    if generatePng
        print([mapList(i).name(1:end-4), '.png'],'-dpng')
    end
end
