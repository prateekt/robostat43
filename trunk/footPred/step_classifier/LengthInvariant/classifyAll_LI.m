function acc = classifyAll_LI(Features, Labels, method, USE_WEKA_METHOD)
%get lengths
lengths = zeros(size(Features,1),1);
for i=1:length(Features)
    lengths(i) = length(Features{i});
end

%compute features for each step
TBL = [];
for i=1:size(Features,1)
    stepFeatures = Features{i};
    
    %quick exit
    if(isempty(stepFeatures))
        continue;
    end
    
    %aggregate row 
    TBL_ROW = [];
    for j=1:size(stepFeatures,2)
        fList = stepFeatures(:,j);
        TBL_ROW = [TBL_ROW, mean(fList), min(fList),max(fList),std(fList), mean(fList)-2*std(fList), mean(fList)+2*std(fList)];   
    end
        
    %put row in table
    TBL = [TBL;TBL_ROW];
end

TBL = [TBL,Labels(lengths > 0)];

%classify
if(USE_WEKA_METHOD)
    acc = runWEKAMethod(TBL,method);
else
    acc = l1o(TBL(:,1:(end-1)),TBL(:,end),method);
end