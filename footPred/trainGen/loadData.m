%load reference data files
load('rawTrainingData/1stWalk_rectangles_020810_15_39/HolodeckOutput/Synchronized1stWalk_rectangle_020810_15_39.txt');
GT1 = Synchronized1stWalk_rectangle_020810_15_39;
load('rawTrainingData/2ndWalk_rectangles_otherDir_020810_16_33/HolodeckOutput/Synchronized2ndWalk_rectangles_otherDir_020810_16_33.txt');
GT2 = Synchronized2ndWalk_rectangles_otherDir_020810_16_33;
load('rawTrainingData/3rdWalk_straight_020810_16_41/HolodeckOutput/Synchronized3rdWalk__straight_020810_16_41.txt');
GT3 = Synchronized3rdWalk__straight_020810_16_41;
load('rawTrainingData/4thWalk_8_020810_16_46/HolodeckOutput/Synchronized4thWalk_8_020810_16_44.txt');
GT4 = Synchronized4thWalk_8_020810_16_44;
load('rawTrainingData/5thWalk_straight_fast_020810_16_51/HolodeckOutput/Synchronized5thWalk_straight_fast_020810_16_51.txt');
GT5 = Synchronized5thWalk_straight_fast_020810_16_51;
load('rawTrainingData/6thWalk_onTable_030810_15_14/HolodeckOutput/Synchronized6thWalk_onTable_030810_15_14.txt');
GT6 = Synchronized6thWalk_onTable_030810_15_14;

%load IMU data files
load('rawTrainingData/1stWalk_rectangles_020810_15_39/IMURaw.txt');
IMU1 = IMURaw;
load('rawTrainingData/2ndWalk_rectangles_otherDir_020810_16_33/IMURaw.txt');
IMU2 = IMURaw;
load('rawTrainingData/3rdWalk_straight_020810_16_41/IMURaw.txt');
IMU3 = IMURaw;
load('rawTrainingData/4thWalk_8_020810_16_46/IMURaw.txt');
IMU4 = IMURaw;
load('rawTrainingData/5thWalk_straight_fast_020810_16_51/IMURaw.txt');
IMU5 = IMURaw;
load('rawTrainingData/6thWalk_onTable_030810_15_14/IMURaw.txt');
IMU6 = IMURaw;

%do step segmentation on reference data
[steps1, lv1] = stepSeg(GT1(:,3),GT1(:,5),GT1(:,6));
[steps2, lv2] = stepSeg(GT2(:,3),GT2(:,5),GT2(:,6));
[steps3, lv3] = stepSeg(GT3(:,3),GT3(:,5),GT3(:,6));
[steps4, lv4] = stepSeg(GT4(:,3),GT4(:,5),GT4(:,6));
[steps5, lv5] = stepSeg(GT5(:,3),GT5(:,5),GT5(:,6));
[steps6, lv6] = stepSeg(GT6(:,3),GT6(:,5),GT6(:,6));

%synchronize with IMU data
stepsIMU1 = synchBySteps(steps1,GT1, IMU1);
stepsIMU2 = synchBySteps(steps2,GT2, IMU2);
stepsIMU3 = synchBySteps(steps3,GT3, IMU3);
stepsIMU4 = synchBySteps(steps4,GT4, IMU4);
stepsIMU5 = synchBySteps(steps5,GT5, IMU5);
stepsIMU6 = synchBySteps(steps6,GT6, IMU6);

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

    %get octant label by cases
    if(x < 0 && y < 0 && z < 0)
        label = 0;
    elseif(x < 0 && y < 0 && z >= 0)
        label = 1;
    elseif(x < 0 && y >= 0 && z < 0)
        label = 2;
    elseif(x < 0 && y >= 0 && z >= 0)
        label = 3;
    elseif(x >= 0 && y < 0 && z < 0)
        label = 4;
    elseif(x >= 0 && y < 0 && z >= 0)
        label = 5;
    elseif(x >= 0 && y >= 0 && z < 0)
        label = 6;
    elseif(x >= 0 && y >= 0 && z >= 0)
        label = 7;
    end 
    octantLabels(i) = label;

end

%save data set
Features = IMUAll;
Labels = octantLabels;
save('TrainingSet.mat', 'Features','Labels');