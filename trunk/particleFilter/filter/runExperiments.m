%clear;
expList = makeExpList();

exps = [3 6 15 36 43];
 names = [223 226 2215 2236 2243];


for i = 1:5
     exp = exps(i);
    testFilter(expList(exp, 2:5), expList(exp, 6), expList(exp, 7), names(i));
    
end