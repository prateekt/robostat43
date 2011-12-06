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

xFeatures = xLab_train;

%regress features
LOOK_AHEAD=101;
F_NUM = 1;
ests = zeros(size(xFeatures,1),101);
for i=1:(size(xFeatures,1)-LOOK_AHEAD)
    
    %run GP
    x_in = yFeatures(1:i,1); %time
    y_in = xFeatures(1:i,F_NUM); %feature
    z_in = yFeatures((i+1):(i+LOOK_AHEAD),1); %time
    m = regress(x_in,y_in,z_in,1);

    %store estimate
    ests(i,:) = m;
    
    i
end

save('AllReg1.mat');