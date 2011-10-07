%clear;
expList = makeExpList();


for i = 1:72
    
    testFilter(expList(i, 2:5), expList(i, 6), expList(i, 7), expList(i,1));
    
end