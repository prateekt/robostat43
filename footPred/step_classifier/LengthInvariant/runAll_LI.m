%MATLAB classifiers
%KNN_accs = classifyAll_LI(Features, Labels, 1, false);
%DT_accs = classifyAll_LI(Features, Labels, 2, false);

%WEKA classifiers
ZERO_R_accs = classifyAll_LI(Features, Labels, 1, true);
J48_accs = classifyAll_LI(Features, Labels, 2, true);
NAIVE_BAYES_accs = classifyAll_LI(Features, Labels, 3, true);
BASIC_BAYES_NET_accs = classifyAll_LI(Features, Labels, 4, true);
ATTR_SELECTED_accs = classifyAll_LI(Features, Labels, 5, true);

save allClassifierResults.mat; 


