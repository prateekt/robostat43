function TBL = getLITable(Features,Labels)

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
        
        %add mode of distribution as feature
        [f,xi] = ksdensity(fList);
        [maxF,maxInd] = max(f);
        modeF = xi(maxInd);
        
        TBL_ROW = [TBL_ROW, mean(fList), min(fList),max(fList), median(fList), mode(fList), std(fList), mean(fList) - std(fList), mean(fList) + std(fList), sum(fft(fList)),modeF];   
    end
    
    %put row in table
    TBL = [TBL;TBL_ROW];
end

TBL = [TBL,Labels(lengths > 0)];