function fileName = GetFilename(labelIndex)

currentExperiment = 'normalizedFFT';

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name , currentExperiment, '.arff');
close all;