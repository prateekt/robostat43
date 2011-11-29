function pos = intUp(IMU)

firstRow = zeros(1,13);
IMU = [firstRow;IMU];
pos = zeros(size(IMU,1),3);
for i=1:size(IMU,1)
    
    %extract pieces
    acc = IMU(i,4:6);
    vel = IMU(i,7:9);
    
    if(i > 1)
        livetime = IMU(i,3) - IMU(i-1,3);    
        pos(i,:) = pos(i-1,:) + vel*livetime + acc*livetime^2;
    else
        livetime = IMU(i,3);
        pos(i,:) = vel*livetime + acc*livetime^2;
    end
    
end