%MATLAB classifiers
KNN_accs = classifyAllSizes(Features, Labels, 1, false);
DT_accs = classifyAllSizes(Features, Labels, 2, false);

%WEKA classifiers
ZERO_R_accs = classifyAllSizes(Features, Labels, 1, true);
J48_accs = classifyAllSizes(Features, Labels, 2, true);
NAIVE_BAYES_accs = classifyAllSizes(Features, Labels, 3, true);
BASIC_BAYES_NET_accs = classifyAllSizes(Features, Labels, 4, true);
ATTR_SELECTED_accs = classifyAllSizes(Features, Labels, 5, true);

save allClassifierResults.mat; 


