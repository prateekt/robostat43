function pennePlot(Features, Labels, featureIndex, label)

figure(1);
hold on;
for i=1:length(Features)
    
    %add to plot
    if(Labels(i)==label && ~isempty(Features{i}))
        step = Features{i};
        size(step,1)
        plot(step(:,1)-step(1,1),step(:,featureIndex),'s-');        
        pause(1);
    end
    getframe(gcf);
end

hold off;