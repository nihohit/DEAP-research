function fileName = GetFilename(labelIndex)

currentExperiment = 'PWelch';

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name , currentExperiment, '.arff');
close all;