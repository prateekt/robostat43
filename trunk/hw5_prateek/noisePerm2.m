%% flags

%labels to learn class vs. class model
label1=1400;
label2=1103;
TRAIN= false;
NUM_NOISY_F = 6;

%hyperparameters
v=2; %squared exponential kernel bandwidth
sigma=5; %noise model variable in noisy kernel

%% load training data

%load training file
rand('twister',5489);
load oakland_part3_am_rf.node_features;
fullLoad = oakland_part3_am_rf;
clear oakland_part3_am_rf;

%extract training set features and labels
fullFeatures1 = fullLoad(:,[3,6:end]);
fullLabels = fullLoad(:,5);
clear fullLoad;

%extract features and labels of two class case
indices = fullLabels==label1 | fullLabels==label2;
fTrain = fullFeatures1(indices,:);
lTrain = fullLabels(indices);
lTrain(lTrain==label1) = 1;
lTrain(lTrain==label2) = -1;

%rand perm labels and features to ensure we get a good distribution
r = randperm(size(fTrain,1));
fTrain = fTrain(r,:);
lTrain = lTrain(r);

%% load test set

%load test file
load oakland_part3_an_rf.node_features;
testLoad = oakland_part3_an_rf;
clear oakland_part3_an_rf;

%extract training set features and labels
fullFeatures1 = testLoad(:,[3,6:end]);
fullLabels = testLoad(:,5);
clear testLoad;

%extract features and labels of two class case
indices = fullLabels==label1 | fullLabels==label2;
fTest = fullFeatures1(indices,:);
lTest = fullLabels(indices);
lTest(lTest==label1) = 1;
lTest(lTest==label2) = -1;

%rand perm labels and features to ensure we get a good distribution
r = randperm(size(fTest,1));
fTest = fTest(r,:);
lTest = lTest(r);

%% clear memory
save('dats.mat','fTrain','lTrain','fTest', 'lTest','v','sigma', 'TRAIN', 'NUM_NOISY_F', 'label1','label2');
clear all;
load('dats.mat','fTrain','lTrain','fTest','v','sigma', 'TRAIN', 'NUM_NOISY_F', 'label1','label2');

%% Make data noisy
fTrain  = [fTrain,fTrain(:,1:6)+rand(size(fTrain,1),NUM_NOISY_F)];
fTest   = [fTest,fTest(:,1:6)+rand(size(fTest,1),NUM_NOISY_F)];

%% try gp on data

%we have a sizing constant for what data set size to use. We need to make
%sure we have a dataset that will generate kernel matrices that do not
%exceed MATLAB matrix size. Ideally, we would generate as large a kernel
%matrix as we need and store in a database, looking up elements as we need.
if((label1==1400 && label2==1103) || (label1==1103 && label2==1400))
    SC = 2;
elseif((label1==1100 && label2==1103) || (label1==1103 && label2==1100))
    SC=1;
elseif((label1==1400 && label2==1100) || (label1==1100 && label2==1400))
    SC=2;
elseif((label1==1200 && label2==1400) || (label1==1400 && label2==1200))
    SC=10;
elseif((label1==1200 && label2==1100) || (label1==1100 && label2==1200))
    SC=10;
elseif((label1==1200 && label2==1103) || (label1==1103 && label2==1200))
    SC=10;
elseif((label1==1004 && label2==1400) || (label1==1400 && label2==1004))
    SC=3;
elseif((label1==1004 && label2==1100) || (label1==1100 && label2==1004))
    SC=2;
elseif((label1==1004 && label2==1200) || (label1==1200 && label2==1004))
    SC=10;
elseif((label1==1004 && label2==1103) || (label1==1103 && label2==1004))
    SC=2;
end

if(~TRAIN)
    m = computeMean(fTrain(1:size(lTrain,1)/SC,:),lTrain(1:size(lTrain,1)/SC,:),fTest,v,sigma);
else
    m = computeMean(fTrain(1:size(lTrain,1)/2,:),lTrain(1:size(lTrain,1)/2,:),fTrain((size(lTrain,1)/2+1):size(lTrain,1),:),v,sigma);
end
%% present accuracy
load('dats.mat','lTest');
y = -1*(m<0) + 1*(m>=0);
if(~TRAIN)
    acc = (sum(y==lTest)) / size(fTest,1)
else
    acc = sum(lTrain((size(lTrain,1)/2+1):size(lTrain,1))==y) / (length(lTrain)/2)
end