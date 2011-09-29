function [X_t, W_t] = particleFilter(X_tml, u_t,z_t, alpha, map, RESAMPLE)

%size calc
M = size(X_tml,1);
N = size(X_tml,2);

%empty set of particles and weights
X_bar_t = zeros(M,N);
W_t = zeros(M,1);

%sample loop
for m=1:M
    x_t = sample_motion_model_odometry(u_t, X_tm1(m,:), alpha);
    W_t(m) = observation_model_weight(z_t, x_t, map);
    X_bar_t(m,:) = [x_t, W_t(m)]; 
end    

%normalize weights
X_bar_t(:,end) = X_bar_t(:,end) / sum(X_bar_t(:,end));
W_t = W_t / sum(W_t);

%resample if needed and return
if(RESAMPLE)
    X_t = low_variance_sampler(X_bar_t, W_t);
    W_t = X_bar_t(:,end);
else
    X_t = X_bar_t;
end