function robotData = parseRobotDataLog(file)

% open file
fid = fopen(file);

%read file in line by line
tline = fgets(fid);
odPacketCount = 1;
lPacketCount = 1;
while ischar(tline)
    
    %see what type of data packet it is
    packetType = tline(1);
    if(packetType=='L')
        
        %parse Laser packet
        parsedDoubles = sscanf(tline(3:end),'%lg');
        
        %add new packet to structure
        Laser.x(lPacketCount) = parsedDoubles(1);
        Laser.y(lPacketCount) = parsedDoubles(2);
        Laser.theta(lPacketCount) = parsedDoubles(3);
        Laser.x1(lPacketCount) = parsedDoubles(4);
        Laser.y1(lPacketCount) = parsedDoubles(5);
        Laser.theta1(lPacketCount) = parsedDoubles(6);
        Laser.r(lPacketCount,:) = parsedDoubles(7:186);
        Laser.ts(lPacketCount) = parsedDoubles(187);
        lPacketCount = lPacketCount + 1;
        
    elseif(packetType=='O')
        
        %parse odometry packet
        parsedDoubles = sscanf(tline, '%*s %lg %lg %lg %lg');
        
        %add new packet to structure
        Odometry.x(odPacketCount) = parsedDoubles(1);
        Odometry.y(odPacketCount) = parsedDoubles(2);
        Odometry.theta(odPacketCount) = parsedDoubles(3);
        Odometry.ts(odPacketCount)  =parsedDoubles(4);
        odPacketCount = odPacketCount + 1;

    end
    
    %get next line
    tline = fgets(fid);
end

%close file
fclose(fid);

%rtn structure
robotData.Odometry = Odometry;
robotData.Laser = Laser;