function m = computeMean(x,f,x_star)

%compute parts
K_11 = SEK(x_star,x_star);
K_12 = SEK(x_star,x);
K_21 = SEK(x_star,x)';
K_xx_inv = SEK(x,x);
alpha = (K_xx_inv \ f);

%compute mean
m = K_12*alpha;
