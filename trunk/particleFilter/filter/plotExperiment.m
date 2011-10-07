function plotExperiment( particleSets )
%PLOTEXPERIMENT Summary of this function goes here
%   Detailed explanation goes here
load parsedData.mat;
for i=1:length(particleSets)
    plotParticlesOnMap(particleSets{i}, MAP)
end
end

