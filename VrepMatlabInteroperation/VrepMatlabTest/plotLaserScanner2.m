%% Get laser scanner data

[img1,img2]=getVisionScanner(); % 1x256 1x256 double
scn = [(img2),img1]; % 1x541 double

%% Plot laser scanner

x = zeros(1,541);
y = zeros(1,541);
xtmp = zeros(1,541);
ytmp = zeros(1,541);
%i = 0;

%theta = 0:0.00872664619237:(0.00872664619237*(size(scn,2)-1));
rho = 135;
dtheta = (rho/(size(scn,2)-1))*pi/180;
theta = (-(rho/2)*pi/180):dtheta:((rho/2)*pi/180);
%theta = (0:dtheta:((rho)*pi/180));
scn2 = lensdistort(scn,0.5)
[x,y] = pol2cart(theta, scn2);

all = [x;y];

figure(1)
plot(scn)
figure(2)
plot(pol2cart(theta,scn2))

%{
figure(2)
plot(x,y, 'k.', 'MarkerSize',10)
hold on 
plot(0,0, 'gx')
%}

figure(3)
fill(x, y, 'r')
%%