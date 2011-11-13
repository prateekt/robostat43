clear;
load TrainingSet_sequencePredictor.mat;
load TestSet.mat;
trainLabels = octantLabelSequence + 1;
testlabels = octantLabelsTest + 1;

N = length(trainLabels);

hypList = initHypList(8);

for i = 1:N-5
    newhyps = createHypFromHis(trainLabels(i:i+3));
    hypList = updateHypList(newhyps, trainLabels(i+4), hypList, 8);
    
end

counts = getPredCountsBasic([1 1 1 1], hypList, 8);
