function [ score ] = getHypScore( hypString )
%GETHYPSCORE Summary of this function goes here
%   Detailed explanation goes here


xlocs = strfind(hypString, 'X');

count = length(xlocs);

score = 4 - count;

end

