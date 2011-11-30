function [I1,I2] = generateIndicies(x,y)

I1 = zeros(length(x)*length(y)/2,1);
I2 = zeros(length(x)*length(y)/2,1);
cnt = 1;
for i=1:length(x)
    for j=i:length(y)
        I1(cnt) = i;
        I2(cnt) = j;
        cnt = cnt + 1;
    end
end
