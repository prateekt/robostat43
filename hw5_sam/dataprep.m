%add hw5-data to
clear;
dataset1raw = importdata('oakland_part3_an_rf.node_features', ' ', 3);
rowperm = randperm(max(size(dataset1raw.data)));
data1 = dataset1raw.data(rowperm', :);
dataset1.features = data1(:, [3 6:15]);
dataset1.labels = data1(:,5);
dataset1.coords = data1(:,1:3);

dataset2raw = importdata('oakland_part3_am_rf.node_features', ' ', 3);
rowperm = randperm(max(size(dataset2raw.data)));
data2 = dataset2raw.data(rowperm', :);
dataset2.features = data2(:, [3 6:15]);
dataset2.labels = data2(:,5);
dataset2.coords = data2(:, 1:3);

save ('parsedData.mat','dataset1','dataset2');