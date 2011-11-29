function [MU,SIGMA] = doPrior(x,x_star)

%compute parts of covariance
K_11 = SEK(x_star,x_star);
K_12 = SEK(x_star,x);
K_21 = SEK(x_star,x)';
K_22 = SEK(x,x);

%put together
SIGMA = [[K_11,K_12];[K_21,K_22]];
MU = zeros(length(x)+length(x_star),1);