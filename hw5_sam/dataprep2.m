%add hw5-data to
clear;

dataset1raw = importdata('oakland_part3_an_rf.node_features', ' ', 3);
dataset2raw = importdata('oakland_part3_am_rf.node_features', ' ', 3);

%parameters for random noise
maxvals2 = max(dataset2raw.data);
minvals2 = min(dataset2raw.data);
maxvals1 = max(dataset1raw.data);
minvals1 = min(dataset1raw.data);
labelset = [1004 1100 1103 1200 1400];

numRandFeatures = 10000;

%create random features
featlen = length(minvals2);
randFeatures1 = zeros(numRandFeatures, featlen);
randFeatures2 = zeros(numRandFeatures, featlen);

for i = 1:featlen
    a1 = minvals1(i);
    b1 = maxvals1(i);
    a2 = minvals2(i);
    b2 = maxvals2(i);
    r1 = a1 + (b1-a1).*rand(numRandFeatures,1);
    r2 = a2 + (b2-a2).*rand(numRandFeatures,1);
    randFeatures1(:,i) = r1;
    randFeatures2(:,i) = r2;
    
end

%create labels
for i = 1:numRandFeatures
    
    randFeatures1(i,5) = labelset(randi(5,1));
    randFeatures2(i,5) = labelset(randi(5,1));
    
end

%append new random data to matrices

dataset1raw.data = [dataset1raw.data; randFeatures1];
dataset2raw.data = [dataset2raw.data; randFeatures2];

rowperm = randperm(max(size(dataset1raw.data)));
data1 = dataset1raw.data(rowperm', :);
dataset1.features = data1(:, [3 6:15]);
dataset1.labels = data1(:,5);
dataset1.coords = data1(:,1:3);


rowperm = randperm(max(size(dataset2raw.data)));
data2 = dataset2raw.data(rowperm', :);
dataset2.features = data2(:, [3 6:15]);
dataset2.labels = data2(:,5);
dataset2.coords = data2(:, 1:3);

save ('parsedData2.mat','dataset1','dataset2');


%parameters for random noise