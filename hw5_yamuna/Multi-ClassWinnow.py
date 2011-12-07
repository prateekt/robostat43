from __future__ import with_statement;
from sets import Set;
from Winnow import Winnow;
from random import shuffle,random,randint,gauss;

import argparse;
import csv;
import time;

parser=argparse.ArgumentParser();

parser.add_argument('-f',dest='inFile');  #dataset
parser.add_argument('-o',dest='outFile'); #output of predicted classes
parser.add_argument('-r',dest='num');     #Number of random features to be addded
parser.add_argument('-e',dest='adderror');#Flag to indicate whether noise should be added

args=parser.parse_args();


attributes=10+int(args.num);

#Initialize the winnow class    
winnow=Winnow(attributes,5,1)

exectime=[];

lines=[];
with open(args.inFile) as fpin:
    lines=fpin.readlines();

with open(args.outFile,'w') as fpout:
    for line in lines:
        #Get the features for the dataset record in line
        features=line.strip().split(',');

        if features[0] != 'x1':
            instance=[];

            #Add random features
            if args.num > 0:
                for _ in range(int(args.num)):
                    if args.adderror == 'False':
                        #Add random feature without error
                        instance.append(random());
                    else:
                        #Add random feature with Gaussian error added
                        #to an original feature in the set
                        x=randint(1,10); 
                        instance.append(float(features[x])+gauss(0,1));

            for feature in features:
                instance.append(float(feature));
	          
            tstart=time.clock();
            #Classify the instance
            winnow.classify(instance,0.05);
            tend=time.clock();
            exectime.append((tend-tstart)*1000);
            
	    fpout.write(str(winnow.predicted_class)+'\n');        

#Print accuracy                
winnow.calculateAccuracy();
print max(exectime);
    
