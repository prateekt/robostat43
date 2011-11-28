function [predLabel] = predictLabelHyp(history, hypList, numLabels)

[ counts ] = getPredCountsBasic( history, hypList, numLabels );
[Y, I] = max(counts);
predLabel = I;

end