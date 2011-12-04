function [ w_new ] = onlinesvm_iter( feature, label, lambda, t, w )
%ONLINESVM_ITER Summary of this function goes here
%   Detailed explanation goes here
    feature = feature / norm(feature);
    alpha = 0.2 / (lambda * t);
    if (label * (w' * feature) < 0.8)
        w_new = (1 - alpha*lambda)*w + (alpha*label*feature);
    else
        w_new = (1 - alpha*lambda)*w;
    end

    if (w_new' * w_new > (1/lambda))
        w_new = w_new / sqrt(w_new' * w_new * lambda);
    end
    
end

