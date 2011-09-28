function Odometry = makeFakeLog()

m=1;
b=2;
log = zeros(1000,3);
for i=1:1000
    log(i,1) = i;
    log(i,2) = m*i+b;
    log(i,3) = 0;
end

Odometry.x = log(:,1);
Odometry.y = log(:,2);
Odometry.theta = log(:,3);