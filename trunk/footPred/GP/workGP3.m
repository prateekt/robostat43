%clear past stuff
clear all;

%load data
load('fullLoad.mat','IMU1','GT1');

%load train features and labels
xFeatures = IMU1(:,[3,4,7,10,13]);
yFeatures = IMU1(:,[3,5,8,11,13]);
zFeatures = IMU1(:,[3,6,9,12,13]);
pos_train = intUp(IMU1);
xLab_train = pos_train(2:end,1);
yLab_train = pos_train(2:end,2);
zLab_train = pos_train(2:end,3);

%regress features
LOOK_AHEAD=1;
F_NUM = 3;
ests = zeros(size(xFeatures,1),1);
for i=1:(size(xFeatures,1)-LOOK_AHEAD)
    
    %run GP
    x_in = xFeatures(1:i,1);
    y_in = xFeatures(1:i,F_NUM);
    z_in = xFeatures((i+1):(i+LOOK_AHEAD),1);
    m = regress(x_in,y_in,z_in,1);

    %store estimate
    ests(i+1) = m;
    
    i
end