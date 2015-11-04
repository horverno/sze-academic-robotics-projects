function Layer = DrawWall(laserScan, x, y, theta, mapZoom, mapSize)
  Layer = zeros(mapSize, mapSize);
  laserScan = [cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1] * laserScan; % rotate laser scanner data (orientation)
  if size(laserScan,2) > 684 % todo
   for i = 1:size(laserScan, 2)
    xW = x + int64(mapZoom*laserScan(1, i));
    yW = y + int64(mapZoom*laserScan(2, i));   
    if (xW < mapSize && yW < mapSize && xW > 0 && yW > 0) % if they fit into the map
      Layer(xW, yW) = 40;
    end
    %laserScan(1,i)
   end
  end

end
