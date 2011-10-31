function accs = classifyAllSizes(features, Labels, method, USE_WEKA_METHOD)

%get lengths
lengths = zeros(size(features,1),1);
for i=1:length(features)
    lengths(i) = length(features{i});
end
MAX_STEP_SIZE = max(lengths);

%run iteratively on all step sizes
accs = zeros(MAX_STEP_SIZE,1);
for i=1:MAX_STEP_SIZE
    TBL = fSizeTBL(features, Labels,i);
    if(size(TBL,1) > 1)
        if(USE_WEKA_METHOD)
            accs(i) = runWEKAMethod(TBL,method);
        else
            accs(i) = l1o(TBL(:,1:(end-1)),TBL(:,end),method);
        end
    end
end