function acc = basicPrediction(transitionCounts, testSequence, numLabels)
N = length(testSequence);
acc = 0;
for i = 1: N-1
    
    %predict next label based on current
    
     nextLabel  = predictMostFrequent( transitionCounts, testSequence(i) );
     
      %nextLabel  = predictProbable( transitionCounts, testSequence(i), numLabels );
     
     %compare predcited to actual next label
     
     if nextLabel == testSequence(i+1)
         
         acc = acc + 1;
     end

end

acc = acc / (N-1);

end