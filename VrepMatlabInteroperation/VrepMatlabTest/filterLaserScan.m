%% Convert laser measurements to cartesian coordinates
cart_laser = pol2cart(theta,laser_scan1);
%% Gaussian smoothing filter
x = -1:0.5:1;
f = exp(-x.^2);
% Normalization
f = f./sum(f);
%% Filter
hold on
plot(cart_laser,'r');
plot(filter2(f,cart_laser));
hold off