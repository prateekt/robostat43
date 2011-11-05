function acc = classifyAll_LI(Features, Labels, method, USE_WEKA_METHOD)

%extract table
TBL = getLITable(Features,Labels);

%classify
if(USE_WEKA_METHOD)
    acc = runWEKAMethod(TBL,method);
else
    acc = l1o(TBL(:,1:(end-1)),TBL(:,end),method);
end