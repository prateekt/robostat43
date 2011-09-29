function X_bar_t = updateFilter_motion(X_tml, u_t, alpha)

%size calc
M = size(X_tml,1);
N = size(X_tml,2);

%empty set of particles and weights
X_bar_t = zeros(M,N);

%sample loop
for m=1:M
    x_t = sample_motion_model_odometry(u_t, X_tml(m,:), alpha);
    X_bar_t(m,:) = x_t;
end