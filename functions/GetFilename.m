function fileName = GetFilename(labelIndex)

currentExperiment = 'FFT4Segment0.5Overlap2Run';

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name , currentExperiment, '.arff');
close all;