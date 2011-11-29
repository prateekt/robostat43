%clear past stuff
clear all;

%load data
load('fullLoad.mat','IMU1','GT1', 'IMU2','GT2');

%load train features and labels
trainF_x = IMU1(:,[4,7,10,13]);
trainF_y = IMU1(:,[5,8,11,13]);
trainF_z = IMU1(:,[6,9,12,13]);
pos_train = intUp(IMU1);
xLab_train = pos_train(2:end,1);
yLab_train = pos_train(2:end,2);
zLab_train = pos_train(2:end,3);

%load test features and labels
trainF_x_real = trainF_x(1000:2000,:);
testF_x_real = trainF_x(2001:2011,:);

%{
testF_x = IMU2(:,[4,7,10,13]);
testF_y = IMU2(:,[5,8,11,13]);
testF_z = IMU2(:,[6,9,12,13]);
pos_test = intUp(IMU2);
xLab_test = pos_test(2:end,1);
yLab_test = pos_test(2:end,2);
zLab_test = pos_test(2:end,3);
%}

%format
x=trainF_x_real(:,1);
y=xLab_train(1000:2000);
z=trainF_x_real(:,1);

%run gp
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
%covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
hyp2 = minimize(hyp2, @gp, -1000, @infExact, [], covfunc, likfunc, x, y);
%hyp2 = hyp;
[m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, z);

%plot
%f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
%fill([z; flipdim(z,1)], f, [7 7 7]/8)
hold on; plot(z, m,'r*'); plot(x, y, '+');
