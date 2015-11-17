function participantResult = participantsResults(participantsIndex, numOfLabels, numOfChannels, numOfBands, numOfMovies)

if participantsIndex < 10
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s0', num2str(participantsIndex), '.mat');
else
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s', num2str(participantsIndex), '.mat');
end

load(fileName);
a = figure('visible','off');

participantResult = zeros(numOfMovies,numOfBands * numOfChannels + numOfLabels); 

time = tic;

for i = 1:numOfMovies % movies
    movieTime = tic;
    
    labelValues = zeros(1,numOfLabels);
    for label = 1:numOfLabels
        if(labels(i,label) < 4)
            labelValues(label) = -1;
        elseif(labels(i,label) > 6)
            labelValues(label) = 1;
        end
    end
    
    participantResult(i, :) = GetVideoVector(data,i,labelValues, numOfChannels, numOfBands);
    movieTime = toc(movieTime);
    disp(sprintf('done video %d in %d', i, movieTime));
end

clear data;
totalTime = toc(time);

disp(sprintf('done participant %d, it had taken %d', participantsIndex, totalTime));