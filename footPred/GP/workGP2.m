%clear past stuff
clear all;

%load data
load('fullLoad.mat','IMU1','GT1');

%load train features and labels
trainF_x = IMU1(:,[3,4,7,10,13]);
trainF_y = IMU1(:,[3,5,8,11,13]);
trainF_z = IMU1(:,[3,6,9,12,13]);
pos_train = intUp(IMU1);
xLab_train = pos_train(2:end,1);
yLab_train = pos_train(2:end,2);
zLab_train = pos_train(2:end,3);

%load test features and labels
trainF_x_real = trainF_x(1000:2000,:);
testF_x_real = trainF_x(2001:2011,:);

%format
featureNum=2;
x = trainF_x_real(:,1);
y = trainF_x_real(:,featureNum);
z = [trainF_x_real(:,1);testF_x_real(:,1)];

%{
x=trainF_x_real(:,3);
y=xLab_train(1000:2000);
z=trainF_x_real(:,3);
%}

%run gp
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
%covfunc = {'covSum',{@covSEard,{@covProd,{@covSEard,@covPeriodic}}}}; hyp2.cov = [0;0;0;0]; hyp2.lik = log(0.1);
%covfunc = {'covSum',{@covSEard,{@covProd,{@covSEard,@covPeriodic}}}}; hyp2.cov = [0;0;0;0;0;0;0;0;0;0;0;0;0]; hyp2.lik = log(0.1);
%covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
hyp2 = hyp;
%hyp2 = minimize(hyp2, @gp, -1000, @infExact, [], covfunc, likfunc, x, y);
[m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, z);

%plot
%f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
%fill([z; flipdim(z,1)], f, [7 7 7]/8)
plot(z, m,'r*',x, y, '+',testF_x_real(:,1),testF_x_real(:,featureNum),'g*');