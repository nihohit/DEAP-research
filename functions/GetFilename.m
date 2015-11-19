function fileName = GetFilename(labelIndex)

currentExperiment = 'normalizedFullFFT';

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name , currentExperiment, '.arff');
close all;