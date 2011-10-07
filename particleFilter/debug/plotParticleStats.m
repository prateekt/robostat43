function plotParticleStats(X_tml, MAP, t, numParticles, RESAMPLE, PLOT)

%load cumulative stat variables
global partsKilledResample;
global numResample;
global distsSeries;
global particleSets;


%% Plot overall particle map with particles

%store overall particle set
particleSets{t} = X_tml;

%plot if necesary
if(PLOT)
    plotParticlesOnMap(X_tml, MAP);            
end

%% Plot particles killed per resample

if(RESAMPLE)
    
    %update statistic
    partsKilledResample(numResample) = numParticles-size(unique(X_tml(:,1:3), 'rows'),1);
    numResample = numResample + 1;

    %plot statistic
    if(PLOT)
        figure(65);
        plot(partsKilledResample(2:(numResample-1)));
        title('Number of Particles Killed Per Resample');
        xlabel('Resample Step');
        ylabel('Particles Killed');
    end
    
end
%% Cluster analysis

if(RESAMPLE)
    
    %cluster via k-means
    K=5;
    [inds, clusterCenters] = kmeans(X_tml(:,1:2),K, 'emptyaction','singleton');

    %plot clusters
    if(PLOT)
        figure(66);
        plot(X_tml(inds==1,1),X_tml(inds==1,2),'r*',X_tml(inds==2,1),X_tml(inds==2,2),'b*',X_tml(inds==3,1),X_tml(inds==3,2),'g*', X_tml(inds==4,1),X_tml(inds==4,2),'m*', X_tml(inds==5,1),X_tml(inds==5,2),'y*', clusterCenters(:,1),clusterCenters(:,2), 'ms')
    end
    
    %compute average distance of cluster particles over time.
    dists = zeros(length(clusterCenters),1);
    for i=1:length(clusterCenters)
        x = X_tml(inds==i,1);
        y = X_tml(inds==i,2);
        center = clusterCenters(i,:);
        cDists = sqrt(power(x-center(1),2)+power(y-center(2),2));
        dists(i) = mean(cDists);
    end
    distsSeries(numResample) = mean(dists);
    
    %plot statistic
    if(PLOT)
        figure(67);
        plot(distsSeries(2:(numResample-1)));
        title('Average distance between point and cluster');
        xlabel('Resample Step');
        ylabel('Average distance of particle to cluster');
    end
    
end