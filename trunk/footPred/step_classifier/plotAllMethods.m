%% plot all methods
figure(1);
plot(1:113,KNN_accs*100,1:113,DT_accs*100,1:113,ZERO_R_accs,1:113,J48_accs,1:113,NAIVE_BAYES_accs,1:113,BASIC_BAYES_NET_accs,1:113,ATTR_SELECTED_accs);
legend('K Nearest Neighbor','Decision Trees','ZeroR', 'J48', 'Naive Bayes', 'Bayes Net', 'Attr Selected');
title('Cross-Validation Accuracy for Different Classifiers on Different Step Lengths');
xlabel('Step Length');
ylabel('Cross-Validation Accuracy');

%% plot best method per step length

combAcc = [KNN_accs*100,DT_accs*100,ZERO_R_accs*0,J48_accs,NAIVE_BAYES_accs,BASIC_BAYES_NET_accs,ATTR_SELECTED_accs];
[maxVal,maxInd] = max(combAcc');
baseIndices = 1:113;
KNN_ind = baseIndices(maxInd==1);
KNN_val = maxVal(maxInd==1);
DT_ind = baseIndices(maxInd==2);
DT_val = maxVal(maxInd==2);
ZERO_R_ind = baseIndices(maxInd==3);
ZERO_R_val = maxVal(maxInd==3);
J48_ind = baseIndices(maxInd==4);
J48_val = maxVal(maxInd==4);
NAIVE_BAYES_ind = baseIndices(maxInd==5);
NAIVE_BAYES_val = maxVal(maxInd==5);
BASIC_BAYES_NET_ind = baseIndices(maxInd==6);
BASIC_BAYES_NET_val = maxVal(maxInd==6);
ATTR_SELECTED_ind = baseIndices(maxInd==7);
ATTR_SELECTED_val = maxVal(maxInd==7);

figure(2);
plot(KNN_ind,KNN_val,'s',DT_ind,DT_val,'s',J48_ind,J48_val,'s',NAIVE_BAYES_ind,NAIVE_BAYES_val,'s',BASIC_BAYES_NET_ind,BASIC_BAYES_NET_val,'s',ATTR_SELECTED_ind,ATTR_SELECTED_val,'s');
legend('K Nearest Neighbor','Decision Trees', 'J48', 'Naive Bayes', 'Bayes Net', 'Attr Selected');
title('Best Cross-Validation Accuracy Possible for Step Length with Baseline Classifiers');
xlabel('Step Length');
ylabel('Cross-Validation Accuracy');

%% learn tree for best method

tree = treefit(baseIndices,maxInd,'method','classification');
