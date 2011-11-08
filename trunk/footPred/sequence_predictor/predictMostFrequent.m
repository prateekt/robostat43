%assumes 1-8 labeling

function [ nextLabel ] = predictMostFrequent( transitionCount, currentLabel )
%PREDICTMOSTFREQUENT Summary of this function goes here
%   Detailed explanation goes here
    %get most frequent predictions
    [C, I] = max(transitionCount, [], 2);
    
    nextLabel = I(currentLabel);
    
end

