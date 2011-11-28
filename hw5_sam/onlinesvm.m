function [ w, predictions ] = onlinesvm( features, labels, lambda )
%each col is a features
%labels is binary (possibly multivariate)
[featlen T] = size(features);
w = zeros(featlen, 1);
predictions = zeros(T, 1);
for t = 1:T
    
    label = labels(t);
    cur_feature = features(:,t);
    
    if(w' * cur_feature > 0)
        predictions(t) = 1;
        
    else
        predictions(t) = -1;
    end
    
    w = onlinesvm_iter( cur_feature, label, lambda, t, w );
    
    
end


end

