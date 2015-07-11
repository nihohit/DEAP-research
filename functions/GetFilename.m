function fileName = GetFilename(labelIndex)

name = 'valence';
if labelIndex == 2
    name = 'arousal';
elseif labelIndex == 3
    name = 'dominance';
elseif labelIndex == 4
    name = 'liking';
end
fileName = strcat('../' , name , '.csv');
close all;