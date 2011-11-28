clear;
load TrainingSet_sequencePredictor.mat;
load TestSet.mat;
trainLabels = octantLabelSequence + 1;
testLabels = octantLabelsTest + 1;

N = length(trainLabels);
N2 = length(testLabels);
hypList = initHypList(8);

for i = 1:N-4
    newhyps = createHypFromHis(trainLabels(i:i+3));
    hypList = updateHypList(newhyps, trainLabels(i+4), hypList, 8);
    
end

predLabel = zeros(N2,1);
for j = 1:N2-4
    history = testLabels(j:j+3);
    predLabel(j+4) = predictLabelHyp(history, hypList, 8);
    
    
    
end

acc = getStats(testLabels, predLabel);