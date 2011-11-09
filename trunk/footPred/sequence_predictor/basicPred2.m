function [ acc ] = basicPred2( transitionCounts, testSequence, numLabels )
N = length(testSequence);
acc = 0;
for i = 1: N-2
    
    %predict next label based on current
    
     nextLabel = predictFreq2(transitionCounts, testSequence(i), testSequence(i+1));
     
     %compare predcited to actual next label
     
     if nextLabel == testSequence(i+2)
         
         acc = acc + 1;
     end

end

acc = acc / (N-1);

end

