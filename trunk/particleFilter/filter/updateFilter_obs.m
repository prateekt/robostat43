function X_bar_t = updateFilter_obs(X_tml, z_t, map, RESAMPLE, minRange, maxRange, occupancyThreshold)

%size calc
M = size(X_tml,1);
N = size(X_tml,2);

%update weights loop
X_bar_t = zeros(M,N);
for m=1:M
    x_t = X_tml(m,:);
    weight = observation_model_weight(z_t, x_t, map, occupancyThreshold, minRange, maxRange);
    X_bar_t(m,:) = [x_t(1:3),weight]; 
end    

%smash weights
X_bar_t(:,4) = X_bar_t(:,4) .^ (1/M);

%normalize weights
X_bar_t(:,4) = X_bar_t(:,4) / sum(X_bar_t(:,4));

%resample if needed and return
if(RESAMPLE)
    X_bar_t = low_variance_sampler(X_bar_t, X_bar_t(:,4));
end