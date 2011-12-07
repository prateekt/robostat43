#Implementation of Online Multi-Class Winnow
import random
import math

from sys import stdin,exit
from math import exp,isinf,fabs

class Winnow:

    def __init__(self, attribute_size, class_size, weights_init_val):
        #Constructor
        
        self.alpha=0.5;
        self.weights=[];
        self.weights_sum=[];
        self.attribute_size = attribute_size;
        self.class_size=class_size;
        
        #Initialize weights
        for _ in range(class_size):
            row=[]
            for _ in range(attribute_size):
                row.append(weights_init_val)
            self.weights.append(row)            

        #Initialize confusion matrix
        self.confusion_matrix=[]
        for _ in range(class_size):
            row=[]
            for _ in range(class_size):
                row.append(0)
            self.confusion_matrix.append(row)

        self.predicted_class=-1        

    #Method to classify the instance
    def classify(self, input, alpha):
        self.alpha=alpha
        self.weights_sum=[]

        observed_class=int(input[self.attribute_size])
        #print "Observed_class = ",observed_class                    

        self.predict(input)
        self.update(observed_class, input)    

    #Method to predict the class of the instance
    def predict(self, instance):
        for z in range(self.class_size):        
            #For each class find the sum of the product of the weights
            #and the corresponding feature value
            class_weight_sum=0
            for j in range(self.attribute_size):
                class_weight_sum+=(self.weights[z][j]*instance[j])
            self.weights_sum.append(float(class_weight_sum))
        
        #find the max value of the sum of weights
        max_weight_sum=max(self.weights_sum)

        #The class which corresponds to the max of 
        #the sum of weights is the predicted class
        indices=[]           
        for z in range(self.class_size):
            if self.weights_sum[z] == max_weight_sum:
                indices.append(z)
        if len(indices) > 1:
            self.predicted_class=indices[random.randint(0,len(indices)-1)]
        else:
            self.predicted_class=indices[0]
            
        #print "Predicted class = ", self.predicted_class
        
    def update(self, observed_class, instance):                
        if self.predicted_class == observed_class:
            self.confusion_matrix[self.predicted_class][self.predicted_class]+=1
        else:
            self.confusion_matrix[self.predicted_class][observed_class]+=1
            for z in range(self.class_size):
                #Update weights of all those classes that have sum of weights 
                #greater than the sum of weights of the correct class label
                if (self.weights_sum[z] >= self.weights_sum[observed_class]):
                    normalizer=0;
                    for j in range(self.attribute_size):
                        normalizer += instance[j];
                    for j in range(self.attribute_size):
                        before=self.weights[z][j];
                        #the multiplicative weight update
                        self.weights[z][j] *= exp(-1*self.alpha*(fabs(observed_class-z)/self.class_size)*instance[j]/normalizer);
       

    def calculateAccuracy(self):
        #Accuracy Calculation
        total_correct=0
        total_incorrect=0
        for i in range(self.class_size):
            for j in range(self.class_size):
                if i==j:
                    total_correct+=self.confusion_matrix[i][j]
                else:
                    total_incorrect+=self.confusion_matrix[i][j]                    
        
        print "Correctly classsified instances,", total_correct, ",",float(total_correct*100)/float(total_correct+total_incorrect),"%"
        print "Incorrectly classsified instances,", total_incorrect, ",",float(total_incorrect*100)/float(total_correct+total_incorrect),"%"
        print self.confusion_matrix
        
