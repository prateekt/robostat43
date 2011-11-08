function [ nextLabel ] = predictProbable( tcount, currentLabel, numLabels )
%PREDICTPROBABLE Summary of this function goes here
%   Detailed explanation goes here
    
%get counts for currentLabel

w = tcount(currentLabel, :);

nextLabel = randsample(numLabels, 1, true, w);

end

