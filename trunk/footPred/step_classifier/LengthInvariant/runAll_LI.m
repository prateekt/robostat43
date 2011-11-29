%% extract table
TBL = getLITable(Features,Labels);

%% Run on MATLAB Classifiers

%MATLAB classifiers
%KNN_accs = classifyAll_LI(TBL, 1, false);
%DT_accs = classifyAll_LI(Features, Labels, 2, false);

%% Run on WEKA Classifiers

%WEKA classifiers
%ZERO_R_accs = classifyAll_LI(TBL,1, true);
BASIC_BAYES_NET_accs = classifyAll_LI(TBL, 4, true);
J48_accs = classifyAll_LI(TBL,2, true);
NAIVE_BAYES_accs = classifyAll_LI(TBL, 3, true);
%ATTR_SELECTED_accs = classifyAll_LI(TBL, 5, true);

save allClassifierResults_LI2.mat; 


