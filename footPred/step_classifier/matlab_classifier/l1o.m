function acc = l1o(X,Y, method)

%methods
KNN = 1;
DT = 2;

%iterate through leave 1 out indicies
numCorrect = 0;
for i=1:size(X,1)
    
    %get train set
    before = 1:(i-1);
    after = (i+1):size(X,1);
    train = X([before,after],:);
    trainLabels = Y([before,after]);
        
    %plug into classifier
    if(method==KNN)
        if(size(train,1) < 10)
            K = floor(size(train,1)/2);
        else
            K = 10;
        end        
        label =knnclassify(X(i,:),train,trainLabels,K,'euclidean','nearest');
    elseif(method==DT)
        tree = treefit(train,trainLabels,'method','regression');
        label = eval(tree, X(i,:));
    end
    
    %evaluate
    if(label==Y(i))
        numCorrect = numCorrect + 1;
    end
    
end

acc = numCorrect / length(X);