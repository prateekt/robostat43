function average = iAverage(Features,Labels,feature,label)

%find max of set of steps with given label
maxLivetime = -inf;
for i=1:length(Features)    
    step = Features{i};
    if(~isempty(step) && Labels(i)==label)
        livetime = step(end,3) - step(1,3);
        if(livetime > maxLivetime)
            maxLivetime = livetime;
        end
    end
end

%go through each and interpolate over 0 to max time
N = length(0:0.01:maxLivetime);
ePlots = zeros(sum(Labels==label),N);
for i=1:length(Features)
    step = Features{i};
    if(~isempty(step) && Labels(i)==label)
        time = step(:,3);
        features = step(:,feature);
        extendedPlot = interp1(time-time(1),features,0:0.01:maxLivetime);
        ePlots(i,:) = extendedPlot;
    end
end
ePlots = ePlots';

%average whereever there is an average for bin
average = zeros(N,1);
for i=1:N
    featureVals = ePlots(i,:);
    featureVals = featureVals(~isnan(featureVals));
    average(i) = mean(featureVals);
end