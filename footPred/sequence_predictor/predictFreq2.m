function [ nextLabel ] = predictFreq2( transitionCount, currentLabelm1, currentLabel )
%PREDICTFREQ2 Summary of this function goes here
%   Detailed explanation goes here
%PREDICTMOSTFREQUENT Summary of this function goes here
%   Detailed explanation goes here
    %get most frequent predictions
    [C, I] = max(transitionCount(currentLabelm1,currentLabel, :), [], 3);
    
    nextLabel = I;

end

