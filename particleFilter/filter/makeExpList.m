function expList = makeExpList()
alpha14 = [0.01 0.1];
alpha2 = [0.01 0.1];
alpha3 = [0.01 0.1];

resample = [5 10 20];
sigma = [0.1 1 4];



numExp = 2*2*2*3*3;
expList = zeros(numExp, 7);
index = 1;
for i = 1:2
    
    for j = 1:2
        
        for k = 1:2
            
            for l = 1:3
                
                for m = 1:3
                    expList(index, :) = [index alpha14(i) alpha2(j) alpha3(k) alpha14(i) resample(l) sigma(m)];
                    index = index + 1;
                end
            end
        end
    end
end
end