function m = computeMean(x,f,x_star, v,sigma)

%compute parts
%K_11 = SEK(x_star,x_star);
K_xx = SEK(x,x,v) + sigma*eye(size(x,1));
K_12 = SEK(x_star,x,v);
%K_21 = SEK(x_star,x)';
alpha = (K_xx \ f);

save matrices.mat;

%compute mean
m = K_12*alpha;
