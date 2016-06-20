%% Laser scanner plotted as unweighted and weighted bayesian (sick s300) test loaded from file
%%
if(exist('UnweightedLaser1','var') == 0)
    load('lidar01.mat');
end
close all


%% Plot original
fig1 = figure;
surf(UnweightedLaser4(1:105, 20:120), 'EdgeColor', 'w',  'LineWidth', 0.01, 'FaceColor','interp')
colormap('gray')
%colorbar
set(fig1,'Color',[1,1,1])
set(fig1,'Renderer','zbuffer');


%% Bayesian kernel
KernelSize = 4;
BayesKernel = zeros(KernelSize);
s = 1;
m = KernelSize/2;
[X, Y] = meshgrid(1:KernelSize);
BayesKernel = (1/(2*pi*s^2))*exp(-((X-m).^2 + (Y-m).^2)/(2*s^2));
BayesKernel = BayesKernel / 0.9;

figure, imagesc(BayesKernel)


%% Plot weighted
fig2 = figure;
WeightedLaser = conv2(UnweightedLaser4, BayesKernel, 'valid');
surf(WeightedLaser(1:105, 20:120), 'EdgeColor', 'w',  'LineWidth', 0.01, 'FaceColor','interp')
colormap('gray')
set(fig2,'Color',[1,1,1])
%meshgrid(UnweightedLaser2);





