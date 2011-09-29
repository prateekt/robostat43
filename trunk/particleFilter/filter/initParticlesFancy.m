function [ X_0 ] = initParticlesFancy( num_part, map )
%PARTICLEFILTER Summary of this function goes here
%   Detailed explanation goes here
k = 0;
X_0 = zeros(num_part, 4);
while k < num_part
    a = 1;
    b = 800;
    x = a + (b-a).*rand(1,1);
    y = a + (b-a).*rand(1,1);
    a = -1 * pi;
    b = pi;
    theta = a + (b-a).*rand(1,1);
    
    if (map(round(x), round(y)) == 0)
        k = k+1;
        X_0(k, :) = [x,y,theta,1/num_part];
    end
end
end

