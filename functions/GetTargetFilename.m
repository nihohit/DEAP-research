function fileName = GetTargetFilename(labelIndex, currentExperiment)

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name ,'_', currentExperiment, '_', date ,'.arff');
close all;