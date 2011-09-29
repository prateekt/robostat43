function [ X_0 ] = initParticles( num_part )
%PARTICLEFILTER Summary of this function goes here
%   Detailed explanation goes here
a = 0;
b = 800;
x = a + (b-a).*rand(num_part,1);
y = 300 + (720-300).*rand(num_part,1);

a = -1 * pi;
b = pi;

theta = a + (b-a).*rand(num_part,1);


X_0 = [x y theta];
end

