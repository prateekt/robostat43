function [predLabel] = predictLabelHyp(history, hypList, numLabels)

[ counts ] = getPredCountsBasic( history, hypList, numLabels );
[Y, I] = max(counts(1:numLabels-1));
predLabel = I;

end