function acc = classifyAll_LI(TBL, method, USE_WEKA_METHOD)

%classify
if(USE_WEKA_METHOD)
    acc = runWEKAMethod(TBL,method);
else
    acc = l1o(TBL(:,1:(end-1)),TBL(:,end),method);
end