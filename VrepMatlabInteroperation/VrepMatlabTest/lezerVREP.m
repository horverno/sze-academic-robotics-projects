[img1,img2]=getVisionScanner();
ximg1 = img1;
ximg2 = img2;
%theta = (-135*pi/180):((135.2*pi/180)/300):0
%scn = (fliplr([ximg1(1:240),ximg2(end-233:end)]));
scn = ([ximg2,ximg1]);
fx = -1:0.5:1;
f = sin(-x.^2);
f = f./sum(f);
%scn = filter2(f,scn);
%scn = scn(60:536)
dtheta = 0.0087
    currentAngle = (-135*pi)/180;
    x = zeros(1,size(scn,2));
    y = zeros(1,size(scn,2));
    %phi = 60;
    disp(phi)
    a = 0.5
    m = 1/tan(phi*pi/270);
    for i=2:size(scn,2)
        currentAngle = currentAngle + dtheta;
        x(i) = scn(i)*cos(currentAngle);
        y(i) = scn(i)*sin(currentAngle);
        
        % Skew
%         x(i) = ximg1(i)*cos(currentAngle)+y(i)*-0.8;
%         y(i) = ximg1(i)*cos(currentAngle)+x(i)*-4;
%         x1(i) = ximg2(i)*cos(currentAngle)+y1(i)*0.8;
%         y1(i) = ximg2(i)*cos(currentAngle)+x1(i)*4;
    end
    fill(x,y,'r')
    
    %theta = 0:(((rho*2*pi)/180)/size(scn,2)):(rho*2*pi/180);
    %plot(scn)
    
     pause(0.1)
     drawnow
    %plot(x)
    %plot(scn)
