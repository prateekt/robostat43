clear;
load TrainingSet_sequencePredictor.mat;
load TestSet.mat;
trainlabels = octantLabelSequence + 1;
testlabels = octantLabelsTest + 1;
tcount = getTCounts3(trainlabels, 8);

acc = basicPred3(tcount, testlabels, 8);