function [ acc ] = getStats( trueLabels, predLabels )
%GETSTATS Summary of this function goes here
%   Detailed explanation goes here

N = length(trueLabels);
numCor = 0;
for i = 1:N
    if (trueLabels(i) == predLabels(i))
        numCor = numCor + 1;
        
    end
end


acc = numCor / N;
end

