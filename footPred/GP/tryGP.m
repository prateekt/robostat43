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
%xLab_train = GT1(:,3);
%yLab_train = GT1(:,4);
%zLab_train = GT1(:,5);

%load test features and labels
testF_x = IMU2(:,[4,7,10,13]);
testF_y = IMU2(:,[5,8,11,13]);
testF_z = IMU2(:,[6,9,12,13]);
pos_test = intUp(IMU2);
xLab_test = pos_test(2:end,1);
yLab_test = pos_test(2:end,2);
zLab_test = pos_test(2:end,3);
%xLab_test = GT2(:,3);
%yLab_test = GT2(:,4);
%zLab_test = GT2(:,5);

%gp params
%{
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, trainF, xLab_train);
%}

%meanfunc = @meanConst; hyp.mean = 0;
covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
%covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
[m s2] = gp(hyp, @infExact, [], covfunc, likfunc, trainF_x, xLab_train, testF_x);