function rtn = sample_normal_distribution(b)

%sample from a 0 mean, b variance distribution.
a=-1;
c=1;
rnds = a + (c-a).*rand(12,1);
rtn = (b/6)*sum(rnds);