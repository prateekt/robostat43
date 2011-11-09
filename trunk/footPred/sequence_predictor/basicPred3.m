function [ acc ] = basicPred3( transitionCounts, testSequence, numLabels )
N = length(testSequence);
acc = 0;
for i = 1: N-3
    
    %predict next label based on current
    
     nextLabel = predictFreq3(transitionCounts, testSequence(i), testSequence(i+1), testSequence(i+2));
     
     %compare predcited to actual next label
     
     if nextLabel == testSequence(i+3)
         
         acc = acc + 1;
     end

end

acc = acc / (N-1);

end


