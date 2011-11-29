% # format: x y z node_id node_label [features]

%% load features

%load file
load oakland_part3_am_rf.node_features;
fullLoad = oakland_part3_am_rf;
clear oakland_part3_am_rf;

%extract training and test set
fullFeatures1 = fullLoad(:,6:end);
fullLabels = fullLoad(:,5);
clear fullLoad;

%extract features and labels of two class case
indices = fullLabels==1400 | fullLabels==1103;
fullFeatures = fullFeatures1(indices,:);
fL1 = fullLabels(indices);
fL1(fL1==1400) = 1;
fL1(fL1==1103) = -1;

%extract training set and test set
trainInd = 1:size(fullFeatures,1)/2;
testInd = (length(trainInd)+1):size(fullFeatures,1);
fTrain = fullFeatures(trainInd,:);
lTrain = fL1(trainInd);
fTest = fullFeatures(testInd,:);
lTest = fL1(testInd);

%clear memory
save('AllButThat.mat','fTrain','lTrain','fTest');
clear all;
load AllButThat.mat;

%try gp on data
[MU,SIGMA] = doPost(fTrain, lTrain, fTest);