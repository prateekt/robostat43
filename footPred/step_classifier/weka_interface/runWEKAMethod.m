function [acc,output] = runWEKAMethod(TBL,method)
%% Setup

%paths and params
WEKA_LOC = 'lib/weka.jar';
%arffFile = 'lib/test.arff';
arffFile = 'lib/NN.arff';
NUM_FOLDS_INT = 2;
NUM_FOLDS = num2str(NUM_FOLDS_INT);

%methods
ZERO_R = 1;
J48 = 2;
NAIVE_BAYES = 3;
BASIC_BAYES_NET = 4;
ATTR_SELECTED = 5;

%% write arff file with data

%toArff(TBL, arffFile);

%% Run Method

%run Zero R method
if(method==ZERO_R)
    [status,output] = dos(['java -classpath ', WEKA_LOC, ' weka.classifiers.rules.ZeroR',' -x ',NUM_FOLDS,' -t ', arffFile]);
end

%run J48 Decision Tree method
if(method==J48)
    [status,output] = dos(['java -classpath ', WEKA_LOC, ' weka.classifiers.trees.J48',' -x ',NUM_FOLDS,' -t ', arffFile]);
end    

%run Naive_Bayes method
if(method==NAIVE_BAYES)
    [status,output] = dos(['java -classpath ', WEKA_LOC, ' weka.classifiers.bayes.NaiveBayes',' -x ',NUM_FOLDS,' -t ', arffFile]);
end

%run Basic Bayes Net
if(method==BASIC_BAYES_NET)
    [status,output] = dos(['java -classpath ', WEKA_LOC, ' weka.classifiers.bayes.BayesNet',' -x ',NUM_FOLDS,' -t ',  arffFile, ' -D -Q weka.classifiers.bayes.net.search.local.K2 -- -P 2 -S ENTROPY -E weka.classifiers.bayes.net.estimate.SimpleEstimator -- -A 1.0']);
end

%run attribute selected classifier
if(method==ATTR_SELECTED)
    [status,output] = dos(['java -classpath ', WEKA_LOC, ' weka.classifiers.meta.AttributeSelectedClassifier',' -x ',NUM_FOLDS,' -t ', arffFile]);
end

%% parse out cross-validation accuracy metric

%find line
section = findstr(output, 'Stratified cross-validation');
sectionStr = output(section:end);
bottom = findstr(sectionStr, 'Correctly Classified Instances');
bottomStr = sectionStr(bottom:end);
percent = findstr(bottomStr, '%');
line = bottomStr(1:(percent(1)-2));
for i=1:5
    [tok,line] = strtok(line, ' ');
end    
acc = str2double(tok);