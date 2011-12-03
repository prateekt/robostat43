function K = SEK(x_i,x_j,v)
%v is hyperparameter for squared exponential kernel bandwidth

%squared exponential kernel
N = length(x_i);
M = length(x_j);
[N,M]
if(N==M)
    
    %if square, can do half the work
    K = zeros(N,M);
    for i=1:N
        for j=i:M
            K(i,j) = exp(-1*sum((x_i(i,:)-x_j(j,:)).^2)/(2*v^2));
            K(j,i) = K(i,j);
        end
    end
    
else
    
    %otherwise do all of it
    K = zeros(N,M);
    for i=1:N
        for j=1:M
            K(i,j) = exp(-1*sum((x_i(i,:)-x_j(j,:)).^2)/(2*v^2));
        end    
    end
    
end