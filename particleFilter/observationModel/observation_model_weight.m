function [ wt ] = observation_model_weight( zt, xt, map, occupancyThreshold, minRange, maxRange )
%wt is the weight of the particle at time t
%zt is the observation (i.e. the laser data)
%xt is the state
%some thoughts on xt - for the following code to work, xt must be the state
%of the robot at the time that the reading was taken
%(i.e odometry readings have already been accounted for.)  Is all of the robot
%motion captured in the odometry lines, or will we need to do a mtion model
%step based on the odometry info in the laser reading, or account for
%difference between the state odometry and laser odometry somehow?

%get real world coords of the laser
%since here we are assuming the current odometry has already been taken
%into account, the location of the laser in rw coords is 25 forward of the
%state coords


thetaL = xt(3);

xL = xt(1)+ 2.5* cos(thetaL);

yL = xt(2) + 2.5 * sin(thetaL);

wt = 0;
if(xt(1) < 1 || xt(1) > 790 || xt(2) < 1 || xt(2) > 790)
    return;
end
if(map(round(xt(1)), round(xt(2))) == -1)
    return;
end

if(map(round(xt(1)), round(xt(2))) > 0.1)
    return;
end


%loop over each angle
for angle = 0:179
    
    rangeVal = zt.r(angle +1);
    
    %toss out bad ranges
    if (rangeVal < minRange || rangeVal > maxRange)
        
      continue;  
    end
    rangeAng = (angle) * (pi/180);
    
    %transform range data to xy coords wrt laser coordinate system
    %x and y values are wrt a coordinate system originating at the laser
    %but aligned with the world coordinate system (i.e. the rotation of the
    %robot is accounted for here)
    rangeX_wrtL = rangeVal * cos(rangeAng + thetaL - pi/2);
    rangeY_wrtL = rangeVal * sin(rangeAng + thetaL - pi/2);
    
    
    %transform to map coords and round
    %since the coordinate systems are already aligned, simple addition
    
    rangeX = round(rangeX_wrtL/10 + xL);
    rangeY = round(rangeY_wrtL/10 + yL);
    
    
    %toss out bad hit locations
    if (rangeX < 1 || rangeX > 800)
        
      continue;  
    end
    
    if (rangeY < 1 || rangeY > 800)
        
      continue;  
    end
    
    %lookup map location
    occValue = map(rangeX, rangeY);
    
    %if occupied
    if (occValue > occupancyThreshold)
        wt = wt + 1;
    end
        
%end loop
end
end

