function K = SEK(x_i,x_j)

%hyperparameters
v = 1;

%compute Squared Exponential Kernel
N = length(x_i);
M = length(x_j);
[N,M]
K = zeros(N,M);
for i=1:N
    for j=1:M
        K(i,j,:) = sum(exp(-1*(x_i(i)-x_j(j))^2/(2*v^2)));
    end    
end