[i,j]=getVisionScanner()
img1_con = i(10:220)
img2_con = j(1:250)
%img1_con = img1_con(1:173)
%img2_con = img2_con(1:173)
dtheta = (270/512)*pi/180
theta1 = 0:dtheta:((size(img1_con,2)-1)*dtheta)
theta2 = 0:dtheta:((size(img2_con,2)-1)*dtheta)
full_scan = [fliplr(img1_con),fliplr(img2_con)]
theta2 = 0:dtheta:((size(full_scan,2)-1)*dtheta)
%% Distort
full_scan2 = lensdistort(full_scan,0.7)
%% Gaussian smoothing filter
[fx,fy] = meshgrid(-1:0.5:1,-1:0.5:1);
sigma = 0.3;
f = exp(-fx.^2/(2*sigma^2)-fy.^2/(2*sigma^2));
% Normalization
f = f./sum(f(:));
%% Filter and conversion
[x,y] = pol2cart(theta2,filter2(f,full_scan))
fill(x,y, 'r')