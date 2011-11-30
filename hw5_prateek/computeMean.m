function m = computeMean(x,f,x_star)

%compute parts
%K_11 = SEK(x_star,x_star);
K_xx = SEK(x,x);
K_12 = SEK(x_star,x);
%K_21 = SEK(x_star,x)';
alpha = (K_xx \ f);

%compute mean
m = K_12*alpha;
