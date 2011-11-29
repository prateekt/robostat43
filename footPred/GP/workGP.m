%clear past stuff
clear all;

%generate data
x = 1:20;
y = sind(x*30) + cosd(x*60) + sind(x*50);
%z = [5.5,6.5,7.5, 14.5]';
z = [0.1:0.01:30]';

%format
x=x';
y=y';

%run gp
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
hyp2 = minimize(hyp, @gp, -1000, @infExact, [], covfunc, likfunc, x, y);
[m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, z);

%plot
%f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
%fill([z; flipdim(z,1)], f, [7 7 7]/8)
hold on; plot(z, m,'r*'); plot(x, y, '+');
