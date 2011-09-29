function robotData = parseRobotDataLog2(file)

% open file
fid = fopen(file);

%read file in line by line
tline = fgets(fid);
packetCount = 1;
while ischar(tline)
    
    %see what type of data packet it is
    packetType = tline(1);
    if(packetType=='L')
        
        %parse Laser packet
        parsedDoubles = sscanf(tline(3:end),'%lg');
        
        %add new packet to structure
        robotData.is_laser_packet(packetCount) = 1;
        robotData.x(packetCount) = parsedDoubles(1);
        robotData.y(packetCount) = parsedDoubles(2);
        robotData.theta(packetCount) = parsedDoubles(3);
        robotData.x1(packetCount) = parsedDoubles(4);
        robotData.y1(packetCount) = parsedDoubles(5);
        robotData.theta1(packetCount) = parsedDoubles(6);
        robotData.r(packetCount,:) = parsedDoubles(7:186);
        robotData.ts(packetCount) = parsedDoubles(187);
        packetCount = packetCount  +1;
        
    elseif(packetType=='O')
        
        %parse odometry packet
        parsedDoubles = sscanf(tline, '%*s %lg %lg %lg %lg');
        
        %add new packet to structure
        robotData.is_laser_packet(packetCount) = 0;
        robotData.x(packetCount) = parsedDoubles(1);
        robotData.y(packetCount) = parsedDoubles(2);
        robotData.theta(packetCount) = parsedDoubles(3);        
        robotData.ts(packetCount)  = parsedDoubles(4);
        
        %empty fields
        robotData.x1(packetCount) = -1;
        robotData.y1(packetCount) = -1;
        robotData.theta1(packetCount) = -1;
        robotData.r(packetCount,:) = -1*ones(180,1);
        
        packetCount = packetCount  +1;

    end
    
    %get next line
    tline = fgets(fid);
end

%close file
fclose(fid);