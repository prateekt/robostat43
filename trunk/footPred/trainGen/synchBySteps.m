function stepsIMU = synchBySteps(steps,HolodeckRaw, IMURaw)

%size calc
numSteps = length(steps);
stepsIMU = cell(numSteps,1);

for i=1:numSteps

    %for each step...
    cStep = steps{i};
    
    %find start and end time stamps of step
    stepStartIndex = cStep(1,4);
    stepEndIndex = cStep(end,4);
    stepStartTS = HolodeckRaw(stepStartIndex,1) / 1000;
    stepEndTS = HolodeckRaw(stepEndIndex,1) / 1000;
    
    %find IMU data that falls within time steps for this step
    cStepIMU = IMURaw(IMURaw(:,3) >= stepStartTS & IMURaw(:,3) <= stepEndTS,:);
    
    %save it
    stepsIMU{i} = cStepIMU;
    
end