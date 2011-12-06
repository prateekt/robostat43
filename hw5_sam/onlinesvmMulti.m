function [ w, predictions ] = onlinesvmMulti( features, labels, lambda )
%each col is a features
%labels is binary (possibly multivariate)
[featlen T] = size(features);
w = zeros(featlen, 5);
predictions = zeros(T, 1);
for t = 1:T
    
    label = labels(t,:);
    cur_feature = features(:,t);
    
    predictions(t)   = multiPred(w, cur_feature);
    
    w(:,1) = onlinesvm_iter( cur_feature, label(1), lambda, t, w(:,1) );
    w(:,2) = onlinesvm_iter( cur_feature, label(2), lambda, t, w(:,2) );
    w(:,3) = onlinesvm_iter( cur_feature, label(3), lambda, t, w(:,3) );
    w(:,4) = onlinesvm_iter( cur_feature, label(4), lambda, t, w(:,4) );
    w(:,5) = onlinesvm_iter( cur_feature, label(5), lambda, t, w(:,5) );
    
    
end


end

