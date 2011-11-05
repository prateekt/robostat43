function [stepsPruned, labelVectors] = stepSeg(xPts,yPts,zPts)

%size calc
numPoints = length(xPts);
D_THRESH = 0.5;
STEP_LENGTH = 5;

%set up 
steps = {};
stepNum=1;
prev = [inf,inf,inf];
cStep = [];
lastFlag = false;

%loop
for i=1:numPoints
    
    %get current point -- save index that generated point.
    cPt = [xPts(i),yPts(i),zPts(i),i];
    
    %distance from prev
    d = sqrt(power(cPt(1)-prev(1),2)+power(cPt(2)-prev(2),2)+power(cPt(3)-prev(3),2));
    
    %if stepping, then keep recording points of step
    if(d >= D_THRESH)
        cStep = [cStep;cPt];
    end
    
    %If finishing a step by stopping, then record step.
    if(d < D_THRESH && ~lastFlag)        
        steps{stepNum} = cStep;
        stepNum = stepNum + 1;
        cStep = [];
    end
    
    %update flags
    prev = cPt;
    lastFlag = d < D_THRESH;
    
end

%prune step length
stepsPruned = {};
numPruned = 1;
for i=1:length(steps)
    if(size(steps{i},1) >= STEP_LENGTH)
        stepsPruned{numPruned} = steps{i};
        numPruned = numPruned + 1;
    end
end

%get label vectors
labelVectors = zeros(length(stepsPruned),3);
for i=1:length(stepsPruned)

    %for each step...
    cStep = steps{i};

    %return vector difference between first point and second point.
    labelVectors(i,:) = cStep(1,1:3) - cStep(end,1:3);
    
end