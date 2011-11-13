function [ hypList ] = updateHypList( newHyps, obs, hypList, numLabels )
%UPDATEHYPLIST Summary of this function goes here
%   Detailed explanation goes here


n = length(newHyps);
addList = {};

for i = 1:n
    currentHyps = hypList(:, 1);
    TF = strcmp(newHyps{i}, currentHyps);
    [Y, I] = max(TF);
    if Y == 1
       
        hypList{I,2}(obs) = hypList{I,2}(obs) + 1;
        
    else
        weights  = zeros(1, numLabels);
        weights(obs) = 1;
        t = length(currentHyps);
        hypList{t+1, 1} = newHyps{i};
        hypList{t+1, 2} = weights;
        hypList{t+1, 3} = 0;
        hypList;
        
    end
    
end


end

