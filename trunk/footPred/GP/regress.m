function m = regress(x,y,z,setting)

if(setting==1) 
    likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
    covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
    hyp2 = hyp;
    %hyp2 = minimize(hyp2, @gp, -1000, @infExact, [], covfunc, likfunc, x, y);  
    [m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, z);
end

