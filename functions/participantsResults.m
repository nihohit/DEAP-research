function participantResult = participantsResults(participantsIndex, labelIndex)

if participantsIndex < 10
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s0', num2str(participantsIndex), '.mat');
else
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s', num2str(participantsIndex), '.mat');
end

load(fileName);
a = figure('visible','off');
validValues = find(labels(:,labelIndex) > 6 | labels(:,labelIndex) < 4);
numberOfValid = length(validValues);
participantResult = zeros(numberOfValid,202);

for i = 1:numberOfValid
    label = 1;
    if(labels(validValues(i),labelIndex) < 4)
        label = -1;
    end
    participantResult(i, :) = GetVideoVector(squeeze(data(validValues(i),:,:)),label, participantsIndex);
end

close all;