[img1,img2]=getVisionScanner();
ximg1 = img1;
ximg2 = img2;
%theta = (-135*pi/180):((135.2*pi/180)/300):0
%scn = (fliplr([ximg1(1:240),ximg2(end-233:end)]));
scn = ([zeros(1,50),ximg2,ximg1,ones(1,50)]);
fx = -1:0.5:1;
f = sin(-x.^2);
f = f./sum(f);
%scn = filter2(f,scn);
%scn = scn(60:536)
for alpha=0.01:0.01:5
    scn_distorted = lensdistort(scn,alpha);
    scn_distorted(scn_distorted>1)=0;
    dtheta = 0.0087;
    currentAngle = (-135*pi)/180;
    x = zeros(1,size(scn,2));
    y = zeros(1,size(scn,2));
    %phi = 60;
    a = 0.5
    for i=2:size(scn,2)
        currentAngle = currentAngle + dtheta;
        x(i) = scn_distorted(i)*cos(currentAngle);
        y(i) = scn_distorted(i)*sin(currentAngle);
        
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
end