clear;

%select a parsedData.mat (noise, no noise, etc.)
load parsedData.mat;

%select a dataset (1 or 2)
data = dataset1;

%set the other dataset for held out comparison
dataOther = dataset2;


%create a binary feature one vs. all for ground (1200)

features = data.features';
labels = data.labels;
len = length(labels);

featuresO = dataOther.features';
labelsO = dataOther.labels;
lenO = length(labelsO);

%create matrix of labels
allLabels = ones(len, 6) * -1;
allLabels(labels == 1004,1) = 1;
allLabels(labels == 1100,2) = 1;
allLabels(labels == 1103,3) = 1;
allLabels(labels == 1200,4) = 1;
allLabels(labels == 1400,5) = 1;
allLabels(labels == 1004,6) = 1;
allLabels(labels == 1100,6) = 2;
allLabels(labels == 1103,6) = 3;
allLabels(labels == 1200,6) = 4;
allLabels(labels == 1400,6) = 5;

allLabelsO = ones(lenO, 6) * -1;
allLabelsO(labelsO == 1004,1) = 1;
allLabelsO(labelsO == 1100,2) = 1;
allLabelsO(labelsO == 1103,3) = 1;
allLabelsO(labelsO == 1200,4) = 1;
allLabelsO(labelsO == 1400,5) = 1;
allLabelsO(labelsO == 1004,6) = 1;
allLabelsO(labelsO == 1100,6) = 2;
allLabelsO(labelsO == 1103,6) = 3;
allLabelsO(labelsO == 1200,6) = 4;
allLabelsO(labelsO == 1400,6) = 5;



[ w pred_labels] = onlinesvmMulti(features, allLabels, 0.0001);
[pred_labelsO] = weightvecClassify(featuresO, w);
[acc errors correct] = getStats(allLabels(:,6), pred_labels);
[accO errorsO correctO] = getStats(allLabelsO(:,6), pred_labelsO);
acc_online = acc(end)
acc_heldout = accO(end)

plotLabels = pred_labels;
XYZ = data.coords;

%plot green
hold on;
veg = plotLabels == 1;
vegXYZ = XYZ(veg,:);
plot3(vegXYZ(:,1), vegXYZ(:,2),vegXYZ(:,3), '.g');

%plot green

wire = plotLabels == 2;
wireXYZ = XYZ(wire,:);
plot3(wireXYZ(:,1), wireXYZ(:,2),wireXYZ(:,3), '.r');

%plot green

pole = plotLabels == 3;
poleXYZ = XYZ(pole,:);
plot3(poleXYZ(:,1), poleXYZ(:,2),poleXYZ(:,3), '.m');

%plot green

ground = plotLabels == 4;
groundXYZ = XYZ(ground,:);
plot3(groundXYZ(:,1), groundXYZ(:,2),groundXYZ(:,3), '.k');

%plot green

facade = plotLabels == 5;
facadeXYZ = XYZ(facade,:);
plot3(facadeXYZ(:,1), facadeXYZ(:,2),facadeXYZ(:,3), '.b');
