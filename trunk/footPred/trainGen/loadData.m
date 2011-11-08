%% Load Data and Parse

%load reference data files
load('lib/rawTrainingData/1stWalk_rectangles_020810_15_39/HolodeckOutput/Synchronized1stWalk_rectangle_020810_15_39.txt');
GT1 = Synchronized1stWalk_rectangle_020810_15_39;
load('lib/rawTrainingData/2ndWalk_rectangles_otherDir_020810_16_33/HolodeckOutput/Synchronized2ndWalk_rectangles_otherDir_020810_16_33.txt');
GT2 = Synchronized2ndWalk_rectangles_otherDir_020810_16_33;
load('lib/rawTrainingData/3rdWalk_straight_020810_16_41/HolodeckOutput/Synchronized3rdWalk__straight_020810_16_41.txt');
GT3 = Synchronized3rdWalk__straight_020810_16_41;
load('lib/rawTrainingData/4thWalk_8_020810_16_46/HolodeckOutput/Synchronized4thWalk_8_020810_16_44.txt');
GT4 = Synchronized4thWalk_8_020810_16_44;
load('lib/rawTrainingData/5thWalk_straight_fast_020810_16_51/HolodeckOutput/Synchronized5thWalk_straight_fast_020810_16_51.txt');
GT5 = Synchronized5thWalk_straight_fast_020810_16_51;
load('lib/rawTrainingData/6thWalk_onTable_030810_15_14/HolodeckOutput/Synchronized6thWalk_onTable_030810_15_14.txt');
GT6 = Synchronized6thWalk_onTable_030810_15_14;
load('lib/rawTrainingData/15thWalk_Patrick_mixed_260810_14_00/HolodeckOutput/Synchronized15thWalk_Patrick_mixed_260810_14_00.txt');
GTPatrick = Synchronized15thWalk_Patrick_mixed_260810_14_00;
load('lib/rawTrainingData/16thWalk_Mercedes_270810_09_40/HolodeckOutput/Synchronized16thWalk_Mercedes_270810_09_40.txt');
GTMercedes = Synchronized16thWalk_Mercedes_270810_09_40;

%load IMU data files
load('lib/rawTrainingData/1stWalk_rectangles_020810_15_39/IMURaw.txt');
IMU1 = IMURaw;
load('lib/rawTrainingData/2ndWalk_rectangles_otherDir_020810_16_33/IMURaw.txt');
IMU2 = IMURaw;
load('lib/rawTrainingData/3rdWalk_straight_020810_16_41/IMURaw.txt');
IMU3 = IMURaw;
load('lib/rawTrainingData/4thWalk_8_020810_16_46/IMURaw.txt');
IMU4 = IMURaw;
load('lib/rawTrainingData/5thWalk_straight_fast_020810_16_51/IMURaw.txt');
IMU5 = IMURaw;
load('lib/rawTrainingData/6thWalk_onTable_030810_15_14/IMURaw.txt');
IMU6 = IMURaw;
load('lib/rawTrainingData/15thWalk_Patrick_mixed_260810_14_00/IMURaw.txt');
IMUPatrick = IMURaw;
load('lib/rawTrainingData/16thWalk_Mercedes_270810_09_40/IMURaw.txt');
IMUMercedes =  IMURaw;

%do step segmentation on reference data
[steps1, lv1] = stepSeg(GT1(:,3),GT1(:,5),GT1(:,6));
[steps2, lv2] = stepSeg(GT2(:,3),GT2(:,5),GT2(:,6));
[steps3, lv3] = stepSeg(GT3(:,3),GT3(:,5),GT3(:,6));
[steps4, lv4] = stepSeg(GT4(:,3),GT4(:,5),GT4(:,6));
[steps5, lv5] = stepSeg(GT5(:,3),GT5(:,5),GT5(:,6));
[steps6, lv6] = stepSeg(GT6(:,3),GT6(:,5),GT6(:,6));
[stepsPatrick, lvPatrick] = stepSeg(GTPatrick(:,3),GTPatrick(:,5),GTPatrick(:,6));
[stepsMercedes, lvMercedes] = stepSeg(GTMercedes(:,3),GTMercedes(:,5),GTMercedes(:,6));

%synchronize with IMU data
stepsIMU1 = synchBySteps(steps1,GT1, IMU1);
stepsIMU2 = synchBySteps(steps2,GT2, IMU2);
stepsIMU3 = synchBySteps(steps3,GT3, IMU3);
stepsIMU4 = synchBySteps(steps4,GT4, IMU4);
stepsIMU5 = synchBySteps(steps5,GT5, IMU5);
stepsIMU6 = synchBySteps(steps6,GT6, IMU6);
stepsIMUPatrick = synchBySteps(stepsPatrick,GTPatrick,IMUPatrick);
stepsIMUMercedes = synchBySteps(stepsMercedes,GTMercedes,IMUMercedes);

%% Create Training Set for Step Classifier

%make overall IMU and label set
lvAll = [lv1;lv2;lv3;lv4;lv5;lv6];
IMUAll = [stepsIMU1;stepsIMU2;stepsIMU3;stepsIMU4;stepsIMU5;stepsIMU6];

%make overall label by octants
octantLabels = zeros(length(lvAll),1);
for i=1:length(lvAll)
    
    %get label
    x = lvAll(i,1);
    y = lvAll(i,2);
    z = lvAll(i,3);
    octantLabels(i) = getOctantLabel(x,y,z);

end

%put all steps together into 1 cell
stepsAll = {};
cnt=1;
for i=1:length(steps1)
    stepsAll{cnt} = steps1{i};
    cnt = cnt + 1;
end
for i=1:length(steps2)
    stepsAll{cnt} = steps2{i};
    cnt = cnt + 1;
end
for i=1:length(steps3)
    stepsAll{cnt} = steps3{i};
    cnt = cnt + 1;
end
for i=1:length(steps4)
    stepsAll{cnt} = steps4{i};
    cnt = cnt + 1;
end
for i=1:length(steps5)
    stepsAll{cnt} = steps5{i};
    cnt = cnt + 1;
end
for i=1:length(steps6)
    stepsAll{cnt} = steps6{i};
    cnt = cnt + 1;
end

%compute lengths
IMULengths = zeros(size(IMUAll,1),1);
stepLengths = zeros(size(stepsAll,1),1);
for i=1:size(IMUAll)
    IMULengths(i) = size(IMUAll{i},1);
    stepLengths(i) = size(stepsAll{i},1);
end

%prune out steps with no IMU Data
IMUAllFinal = {};
stepsAllFinal = {};
octantLabelsFinal = [];
cnt = 1;
for i=1:size(IMUAll)
    
    %see if IMU set is empty
    if(isempty(IMUAll{i}))
        continue;
    end
    
    %else add
    IMUAllFinal{cnt} = IMUAll{i};
    stepsAllFinal{cnt} = stepsAll{i};
    octantLabelsFinal(cnt) = octantLabels(i);
    cnt = cnt + 1;
    
end

%save data set
Features = IMUAllFinal';
Labels = octantLabelsFinal';
save('lib/TrainingSet_stepClassifier.mat', 'Features','Labels', 'stepsAllFinal');

%% Create Training Set for Sequence Prediction

%make octant labels for Patrick
octantLabelSequence = zeros(length(lvPatrick),1);
for i=1:length(lvPatrick)
    
    %get label
    x = lvPatrick(i,1);
    y = lvPatrick(i,2);
    z = lvPatrick(i,3);
    octantLabelSequence(i) = getOctantLabel(x,y,z);

end

%save data set
IMUFeatures = stepsIMUPatrick;
GTSteps = stepsPatrick;
save('lib/TrainingSet_sequencePredictor.mat','octantLabelSequence','IMUFeatures','GTSteps');

%% Create Test Set 

%make octant labels for Mercedes
octantLabelsTest = zeros(length(lvMercedes),1);
for i=1:length(lvMercedes)
    
    %get label
    x = lvMercedes(i,1);
    y = lvMercedes(i,2);
    z = lvMercedes(i,3);
    octantLabelsTest(i) = getOctantLabel(x,y,z);

end

%save data set
IMUFeaturesTest = stepsIMUMercedes;
GTStepsTest = stepsMercedes;
save('lib/TestSet.mat','octantLabelsTest','IMUFeaturesTest','GTStepsTest');
