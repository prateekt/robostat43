function K = SEK2(x_i,x_j)
v=1;
K = exp(-1*sum((x_i-x_j).^2)/(2*v^2));