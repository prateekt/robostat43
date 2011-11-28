function [ hypList ] = initHypList( numLabels )
%INITHYPLIST Summary of this function goes here
%   Detailed explanation goes here
weights = zeros(1, numLabels);
%weights(numLabels) = 2;
hypList = cell(1,3);
hypList{1, 1} = 'XXXX';
hypList{1,2} = weights;
hypList{1,3} = 0;


end

