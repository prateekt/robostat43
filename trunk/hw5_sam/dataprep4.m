%add hw5-data to
clear;
dataset1raw = importdata('oakland_part3_an_rf.node_features', ' ', 3);
dataset2raw = importdata('oakland_part3_am_rf.node_features', ' ', 3);

rowperm = randperm(max(size(dataset1raw.data)));
dataset1raw.data = dataset1raw.data(rowperm', :);
rowperm = randperm(max(size(dataset2raw.data)));
dataset2raw.data = dataset2raw.data(rowperm', :);


numRandFeatures = 10000;

len1 = length(dataset1raw.data);
len2 = length(dataset2raw.data);

randFeatureLocs1 = randperm(len1);
randFeatureLocs2 = randperm(len2);

randFeatures1 = dataset1raw.data(randFeatureLocs1(1:numRandFeatures), :);
randFeatures2 = dataset2raw.data(randFeatureLocs2(1:numRandFeatures), :);

randFeatures1(:, 1:3) = randFeatures1(:, 1:3) + 20 * rand(size(randFeatures1(:, 1:3)));
randFeatures2(:, 1:3) = randFeatures2(:, 1:3) + 20 * rand(size(randFeatures2(:, 1:3)));


randFeatures1(:, 6:15) = randFeatures1(:, 6:15) + 0.01 * rand(size(randFeatures1(:, 6:15)));
randFeatures2(:, 6:15) = randFeatures2(:, 6:15) + 0.01 * rand(size(randFeatures2(:, 6:15)));




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

save ('parsedData4.mat','dataset1','dataset2');