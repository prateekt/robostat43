function [ acc ] = basicPredictionOnline( transitionCounts, testSequence, numLabels, priorWeight )
%BASICPREDICTIONONLINE Summary of this function goes here
%   Detailed explanation goes here
N = length(testSequence);
acc = 0;

transitionCounts = transitionCounts * priorWeight;

for i = 1: N-1
    
    %predict next label based on current
    
     nextLabel  = predictMostFrequent( transitionCounts, testSequence(i) );
     
      %nextLabel  = predictProbable( transitionCounts, testSequence(i), numLabels );
     
     %compare predcited to actual next label
     
     if nextLabel == testSequence(i+1)
         
         acc = acc + 1;
     end
     
     %update transitionCounts
     transitionCounts(testSequence(i), testSequence(i+1)) = transitionCounts(testSequence(i), testSequence(i+1)) + 1;

end

acc = acc / (N-1);

end

