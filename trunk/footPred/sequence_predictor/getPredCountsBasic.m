function [ counts ] = getPredCountsBasic( history, hypList, numLabels )
%GETPREDCOUNTSBASIC Summary of this function goes here
%   Detailed explanation goes here

possibleHyps = createHypFromHis(history);

n = length(possibleHyps);
currentHyps = hypList(:, 1);
counts = zeros(1, numLabels);
for i = 1:n
    
    TF = strcmp(possibleHyps{i}, currentHyps);
    [Y, I] = max(TF);
    if Y == 1
       
        counts = counts + hypList{i, 2};
        
    
    end
    
end


end

