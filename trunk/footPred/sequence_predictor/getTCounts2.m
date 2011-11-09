function [ transitionCount ] = getTCounts2( sequence, numLabels )
%GETTCOUNTS2 Summary of this function goes here
%   Detailed explanation goes here
    N = length(sequence);
transitionCount = zeros(numLabels, numLabels, numLabels);

for i = 1:N-2
       transitionCount(sequence(i), sequence(i+1), sequence(i+2)) = transitionCount(sequence(i), sequence(i+1), sequence(i+2)) + 1;

    
end

