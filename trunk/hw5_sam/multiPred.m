function [new_label] = multiPred(w, cur_feature)

indicator = zeros(1,5);

indicator(1) = w(:,1)' * cur_feature;
indicator(2) = w(:,2)' * cur_feature;
indicator(3) = w(:,3)' * cur_feature;
indicator(4) = w(:,4)' * cur_feature;
indicator(5) = w(:,5)' * cur_feature;

[Y new_label] = max(indicator);
end