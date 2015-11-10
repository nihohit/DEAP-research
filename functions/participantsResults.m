function participantResult = participantsResults(participantsIndex)

if participantsIndex < 10
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s0', num2str(participantsIndex), '.mat');
else
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s', num2str(participantsIndex), '.mat');
end

load(fileName);
a = figure('visible','off');

%validValues = find(labels(:,labelIndex) > 6 | labels(:,labelIndex) < 4);
%numberOfValid = length(validValues);
participantResult = zeros(40,644);  % movies x ??

for i = 1:40 % movies
    labelValues = zeros(1,4);
    for label = 1:4
        if(labels(i,label) < 4)
            labelValues(label) = -1;
        elseif(labels(i,label) > 6)
            labelValues(label) = 1;
        end
    end
    
    participantResult(i, :) = GetVideoVector(data,i,labelValues);
end

close all;