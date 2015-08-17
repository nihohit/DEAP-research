function fileName = GetFilename(labelIndex)

name = GetLabelName(labelIndex);
fileName = strcat('../data preprocessing results/' , name , 'SingleUserFft.arff');
close all;