function watchSteps(steps, method)

%methods
RAW_STEPS = 1;
BOUND_PTS = 2;

%watch raw segmented steps
if(method==RAW_STEPS)
    pts = [];
    for i=1:length(steps)

        %update pts set
        pts = [pts; steps{i}];

        %plot
        plot(pts(:,1),'s');
        getframe(gcf);

    end
end

%watch start and end points of steps
if(method==BOUND_PTS)
    pts = [];
    for i=1:length(steps)
        
        %update pts set
        pts = [pts; steps{i}(1,:);steps{i}(end,:)];
        
        %plot
        plot3(pts(:,1),pts(:,2),pts(:,3),'s');
        getframe(gcf);
        
    end
end