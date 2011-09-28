function x_bar_t = low_variance_sampler(X_t, W_t)

%length of M
M = length(X_t);

%new set
X_bar_t = [];

%draw single random number
a=0;
b = M^-1;
r = a + (b-a).*rand(1,1);

c = W_t(1);
i=1;
for m=1:M
    u  = r + (m-1)*M^(-1);
    while u > c
        i = i + 1;
        c = c + W_t(i);
    end
    x_bar_t = [X_bar_t;X_t(i)];
end
