function [ nextLabel ] = predictFreq3( transitionCount, currentLabelm2, currentLabelm1, currentLabel )
%PREDICTFREQ2 Summary of this function goes here
%   Detailed explanation goes here
%PREDICTMOSTFREQUENT Summary of this function goes here
%   Detailed explanation goes here
    %get most frequent predictions
    [C, I] = max(transitionCount(currentLabelm2, currentLabelm1,currentLabel, :), [], 4);
    
    nextLabel = I;

end

