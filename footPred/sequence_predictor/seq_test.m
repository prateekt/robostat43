clear;
load TrainingSet_sequencePredictor.mat;
load TestSet.mat;
trainlabels = octantLabelSequence + 1;
testlabels = octantLabelsTest + 1;
tcount = getTransitionCounts(trainlabels, 8);

acc = basicPredictionOnline(tcount, testlabels, 8, 2);