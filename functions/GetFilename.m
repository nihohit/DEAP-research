function fileName = GetFilename(labelIndex)

currentExperiment = 'segmented_15Segments_removedDeviations';

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name ,'_', currentExperiment,'_', date ,'.arff');
close all;