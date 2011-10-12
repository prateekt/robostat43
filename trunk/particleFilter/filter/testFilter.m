function testFilter(alpha, resampleEveryWhat, SMOOTHING_H_SIGMA, expID)
tic
%%IMPORTANT -- PRESET RANDOM SEED FOR EXPERIMENTATION
%rand('seed',5489);

%% params (default)
robotNum=2;
numParticles = 1000;
occupancyThreshold = 0.65;
minRange = 5;
maxRange = 7500;
%alpha = [0.01,0.01,0.01,0.01];
%resampleEveryWhat = 5;
SMOOTHING_H_SIZE = 5;
%SMOOTHING_H_SIGMA = 4;

%% Set up robot and map

%load robot
load parsedData.mat;
robotData = ROBOT{robotNum};

%smooth map
h = fspecial('gaussian', SMOOTHING_H_SIZE, SMOOTHING_H_SIGMA);
MAP = filter2(h, MAP);

%init particle filter
X_tml = initParticlesFancy(numParticles, MAP);

%% DEBUG VARIABLES INIT
global partsKilledResample;
global numResample;
global distsSeries;
global particleSets;
partsKilledResample = zeros(round(length(robotData.ts)/resampleEveryWhat),1);
numResample=1;
distsSeries= zeros(round(length(robotData.ts)/resampleEveryWhat),1);
particleSets = cell(length(robotData.ts),1);
particleSets{1} = X_tml;

%% loop through robot data
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
        X_tml = updateFilter_obs(X_tml, z_t, MAP, RESAMPLE, minRange, maxRange, occupancyThreshold);
    end
            
    %update statistics and plot if necessary
    %PLOT = false;
    plotParticleStats(X_tml, MAP, i, numParticles, RESAMPLE, PLOT);        
end

%% Save Statistics to File
save(['Experiment_',num2str(expID),'.mat'],'particleSets','distsSeries','partsKilledResample');
toc