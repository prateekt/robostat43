function testFilter()

%params (default)
robotNum=1;
numParticles = 50;
alpha = [0.01,0.01,0.01,0.01];
resampleEveryWhat = 10;

%load robot
load parsedData.mat;
robotData = ROBOT{robotNum};

%init particle filter
X_tml = initParticlesFancy(numParticles, MAP);

%plot initial particles state
plotParticlesOnMap(X_tml, MAP);        

%loop through robot data
%NOTE: Starting with number 2 but might be missing a sensor update.
for i=2:length(robotData.ts)
    
    %set resample flag for time step
    if(mod(i,resampleEveryWhat)==0)
        RESAMPLE = true;
    else
        RESAMPLE = false;
    end
    
    
    
    %do motion update (ALWAYS)
    u_t = [robotData.x(i-1),robotData.y(i-1),robotData.theta(i-1),robotData.x(i),robotData.y(i),robotData.theta(i)];
    X_tml = updateFilter_motion(X_tml, u_t, alpha);        
    
    %do a sensor update if we have a laser packet.
    if(robotData.is_laser_packet(i))
        z_t.r = robotData.r(i,:);        
        X_tml = updateFilter_obs(X_tml, z_t, MAP, RESAMPLE);
    end
    
 
    %plot update
    plotParticlesOnMap(X_tml, MAP);        

end
