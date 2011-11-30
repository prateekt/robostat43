function K = computeKMat(x,y)

%generate all permutation indicies
%{
[I1,I2] = meshgrid(1:length(x),1:length(y));
numPerms = length(x)*length(y);
I1 = reshape(I1,numPerms,1);
I2 = reshape(I2,numPerms,1);
%}
[I1,I2] = generateIndicies(x,y);

%overall matrix to produce
K = zeros(length(x),length(y));

%compute in batches
BATCH_SIZE=1000000;
numBatchesDone=0;
while(numBatchesDone*BATCH_SIZE < numPerms)
    
    %compute indicies of batch
    indices = (numBatchesDone*BATCH_SIZE+1):((numBatchesDone+1)*BATCH_SIZE);
    if(max(indices) > numPerms)
        indices = (numBatchesDone*BATCH_SIZE+1):numPerms;
    end
    
    [min(indices),max(indices)]
    
    %draw batch
    I1_batch = I1(indices);
    I2_batch = I2(indices);
    x_batch = x(I1_batch,:);
    y_batch = y(I2_batch,:);
    
    %do kernel
    k_batch = SEK2(x_batch',y_batch');
    
    %put into K
    inds = sub2ind(size(K),I1_batch,I2_batch);
    K(inds) = k_batch;
    
    %inc
    numBatchesDone = numBatchesDone + 1;
end

LOZ=1
%I1K(I1_batch,I2_batch) = k_batch';