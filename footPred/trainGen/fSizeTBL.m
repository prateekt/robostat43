function TBL = fSizeTBL(Features, Labels,fSize)

%return
TBL = [];

%iterate through features cell
for i=1:length(Features)
    
    %get features for step
    stepFeatures = Features{i};
    
    %if correct length, add to table.
    if(size(stepFeatures,1)==fSize)
        
        %flatten
        stepFeatures = reshape(stepFeatures,1,size(stepFeatures,1)*size(stepFeatures,2));
        
        %add label to table
        stepFeatures = [stepFeatures,Labels(i)];
        
        %add to table
        TBL = [TBL;stepFeatures];
    end
end
