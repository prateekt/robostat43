clear;

load parsedData.mat;


%currently doing dataset1
%create a binary feature one vs. all for ground (1200)

features = dataset1.features';
labels = dataset1.labels;

%select labels to classify
labelsetA = labels == 1100;
labelsetB = labels ~= 1100;
labels(labelsetA) = 1;
labels(labelsetB) = -1;
labels = labels(labelsetA | labelsetB);
features = features(:,labelsetA | labelsetB);




[ w pred_labels] = onlinesvm(features, labels, 1);

[acc errors correct] = getStats(labels, pred_labels);
% plot(errors, 'r');
% hold on;
% plot(correct, 'b');
% %xlim([ 0 20]);

plot(acc);
xlim([ 0 20]);
