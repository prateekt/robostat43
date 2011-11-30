function [MU,SIGMA] = doPost(x, f, x_star)

%flags
VIS=true;
NUM_SAMPLES=10;

%compute parts
K_11 = SEK(x_star,x_star);
K_12 = SEK(x_star,x);
K_21 = SEK(x_star,x)';
K_xx_inv = SEK(x,x);

%compute params
MU = K_12*(K_xx_inv \ f);
SIGMA = K_11 + K_12*(K_xx_inv \ K_21);

%plot distribution
if(VIS)
    samples = mvnrnd(MU,SIGMA,NUM_SAMPLES);
    m = computeMean(x,f,x_star);
    plot(x,f,'bs--',x_star,m,'r*--');
end