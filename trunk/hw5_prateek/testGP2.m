%% load training set

%load training file
load oakland_part3_am_rf.node_features;
fullLoad = oakland_part3_am_rf;
clear oakland_part3_am_rf;

%extract training set features and labels
fullFeatures1 = fullLoad(:,[3,6:end]);
fullFeatures1 = (fullFeatures1 - repmat(mean(fullFeatures1),size(fullFeatures1,1),1))./repmat(var(fullFeatures1),size(fullFeatures1,1),1);
fullFeatures1(:,end) = 1;
fullLabels = fullLoad(:,5);
clear fullLoad;

%extract features and labels of two class case
indices = fullLabels==1400 | fullLabels==1103;
fTrain = fullFeatures1(indices,:);
lTrain = fullLabels(indices);
lTrain(lTrain==1400) = 1;
lTrain(lTrain==1103) = -1;

%% load test set

%load test file
load oakland_part3_an_rf.node_features;
testLoad = oakland_part3_an_rf;
clear oakland_part3_an_rf;

%extract training set features and labels
fullFeatures1 = testLoad(:,[3,6:end]);
fullFeatures1 = (fullFeatures1 - repmat(mean(fullFeatures1),size(fullFeatures1,1),1))./repmat(var(fullFeatures1),size(fullFeatures1,1),1);
fullFeatures1(:,end) = 1;
fullLabels = testLoad(:,5);
clear testLoad;

%extract features and labels of two class case
indices = fullLabels==1400 | fullLabels==1103;
fTest = fullFeatures1(indices,:);
lTest = fullLabels(indices);
lTest(lTest==1400) = 1;
lTest(lTest==1103) = -1;

%% clear memory
save('dats.mat','fTrain','lTrain','fTest', 'lTest');
clear all;
load('dats.mat','fTrain','lTrain','fTest');

%% try gp on data
m = computeMean(fTrain(1:size(lTrain,1)/2,:),lTrain(1:size(lTrain,1)/2,:),fTest);