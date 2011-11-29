function p = mvn3(X,MU,SIGMA)

%find k
k = length(MU);
NUM_VAL = size(X,1);

%compute vals
p = zeros(NUM_VAL,1);
for i=1:NUM_VAL
    p(i) = (2*pi)^(-k/2)*det(SIGMA)^(-1/2) * exp((-1/2)*(X(i,:)-MU)*inv(SIGMA)*(X(i,:)-MU)');
end
