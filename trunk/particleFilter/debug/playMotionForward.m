function playMotionForward(x,y)

for i=1:length(x)
    plot(x(1:i),y(1:i),'s');
    getframe(gcf);
end