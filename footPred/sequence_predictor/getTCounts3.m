function [ transitionCount ] = getTCounts3( sequence, numLabels  )
%GETTCOUNTS3 Summary of this function goes here
%   Detailed explanation goes here
N = length(sequence);
transitionCount = zeros(numLabels, numLabels, numLabels, numLabels);

for i = 1:N-3
       transitionCount(sequence(i), sequence(i+1), sequence(i+2), sequence(i+3)) = transitionCount(sequence(i), sequence(i+1), sequence(i+2), sequence(i+3)) + 1;

    

end

