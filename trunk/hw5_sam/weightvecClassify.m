function [ predictions ] = weightvecClassify( features, w )
[featlen T] = size(features);

predictions = zeros(T, 1);
for t = 1:T
    
    
    cur_feature = features(:,t);
    
    predictions(t)   = multiPred(w, cur_feature);
    
   
    
end

end

