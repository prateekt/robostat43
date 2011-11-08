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
    for j=size(stepFeatures,2)
        fList = stepFeatures(:,j);
        
        %add mode of distribution as feature
        [f,xi] = ksdensity(fList);
        [maxF,maxInd] = max(f);
        modeF = xi(maxInd);
        
        %compute numerical gradient
        grad = gradient(fList);
        s2 = gradient(grad);
        
        %add statistics about list
        TBL_ROW = [TBL_ROW, sum(fList), mean(fList), min(fList),max(fList), median(fList), mode(fList), std(fList), mean(fList) - 2*std(fList), mean(fList) + 2*std(fList), modeF, f(1), f(end), mean(fList)/std(fList), sum(autocorr(fList))];

        %add statistics about gradient
        fList = grad;
        TBL_ROW = [TBL_ROW, sum(fList), mean(fList), min(fList),max(fList), median(fList), mode(fList), std(fList), mean(fList) - 2*std(fList), mean(fList) + 2*std(fList), modeF, f(1), f(end), mean(fList)/std(fList), sum(autocorr(fList))];

        %add second derivative stats
        fList = s2;
        TBL_ROW = [TBL_ROW, sum(fList), mean(fList), min(fList),max(fList), median(fList), mode(fList), std(fList), mean(fList) - 2*std(fList), mean(fList) + 2*std(fList), modeF, f(1), f(end), mean(fList)/std(fList), sum(autocorr(fList))];
        
    end
    
    %put row in table
    TBL = [TBL;TBL_ROW];
end

TBL = [TBL,Labels(lengths > 0)];