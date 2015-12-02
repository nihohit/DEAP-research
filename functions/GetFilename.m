function fileName = GetFilename(labelIndex)

currentExperiment = 'fullFFT';

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name , currentExperiment, '.arff');
close all;