function fileName = GetFilename(labelIndex)

currentExperiment = 'fullFfftRemovedDeviations';

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name ,'_', currentExperiment,'_', date ,'.arff');
close all;