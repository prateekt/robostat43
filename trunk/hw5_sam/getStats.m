function [ acc_overtime errors_overtime correct_overtime] = getStats( true_labels, predicted_labels )

T = length(true_labels);
correct_count = 0;
incorrect_count = 0;
acc_overtime = zeros(1, T);
errors_overtime = zeros(1, T);
correct_overtime = zeros(1, T);
for i = 1:T
    
    if (true_labels(i) == predicted_labels(i))
        
        correct_count = correct_count + 1;
        
    else
        incorrect_count = incorrect_count + 1;
        
    end
    
    acc_overtime(i) = correct_count / i;
    errors_overtime(i) = incorrect_count;
    correct_overtime(i) = correct_count;
    
end



end

