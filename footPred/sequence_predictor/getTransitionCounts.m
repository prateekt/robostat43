%assumes octant labels 1-8;
function transitionCount = getTransitionCounts(sequence, numLabels)

N = length(sequence);
transitionCount = zeros(numLabels);

for i = 1:N-1
       transitionCount(sequence(i), sequence(i+1)) = transitionCount(sequence(i), sequence(i+1)) + 1;
end


end