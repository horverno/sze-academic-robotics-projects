%% Laser scanner (sick s300) test loaded from file
%%
if(exist('kinect3d01','var') == 0)
    load('vrepscene01.mat');
end

close all


%% Plot original sick data
figure('Name', 'Laser scanner')
daspect([1 1 1])
figure
subplot(1,2,1);
plot(sick3d01(1,:),sick3d01(2,:), 'r.')

subplot(1,2,2);
plot(sick3d01(1,:),sick3d01(2,:))


%%