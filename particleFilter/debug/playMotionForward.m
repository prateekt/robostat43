function playMotionForward(x,y)

for i=1:length(x)
    i
    plot(x(1:i),y(1:i),'s');
    getframe(gcf);
    pause(0.25);
end