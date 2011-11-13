function [ currentHypo] = createHypFromHis( hist )
%CREATEHYPFROMHIS Summary of this function goes here
%   Detailed explanation goes here
%history is an array of label numbers
    currentHypo = cell([length(hist)^2 1]);
    strHist = cell([length(hist) 1]);
for i = 1:length(hist)
    strHist{i,1} = num2str(hist(i));
end
t = 1;
for i = [strHist{1} 'X']
    for j = [strHist{2} 'X']
        for k = [strHist{3} 'X']
            for l = [strHist{4} 'X']
                %for m = [strHist{5} 'X']
                    currentHypo{t, 1} = strcat(i,j,k,l);
                    t = t+1;
                %end
            end
        end
    end
end

end

