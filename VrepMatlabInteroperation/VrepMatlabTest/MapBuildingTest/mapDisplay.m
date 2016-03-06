if(exist('map01a','var') == 0)
    load('map01a.mat');
end
myColorMap = flipud([autumn; ones(6,3); flipud(winter); zeros(1,3)]); % the color map for blue white red
colormap(gray)
image(map01a,'CDataMapping','scaled');
h = zoom; % zoom by default
caxis([0,1])
set(h,'Motion','both','Enable','on'); % zoom by default
colorbar