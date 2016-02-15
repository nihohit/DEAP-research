function participantResult = participantsResults(participantsIndex, numOfLabels, numOfChannels, numOfBands, ...
    numOfMovies, numOfSegments)

if participantsIndex < 10
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s0', num2str(participantsIndex), '.mat');
else
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s', num2str(participantsIndex), '.mat');
end

load(fileName);
a = figure('visible','off');

data = data(:,1:numOfChannels,:); %remove excess channels

participantResult = zeros(numOfMovies,numOfSegments * numOfBands * numOfChannels + numOfLabels); 

fftResult = RunFftOnSegmentedData(data, size(labels), numOfChannels, numOfMovies, numOfBands, numOfSegments);

for movieIndex = 1:numOfMovies % movies
    %enter labels
    for label = 1:numOfLabels
        if(labels(movieIndex,label) < 4)
            participantResult(movieIndex,label) = -1;
        elseif(labels(movieIndex,label) > 6)
            participantResult(movieIndex,label) = 1;
        end
    end
    
    for channelIndex = 1:numOfChannels % movies
        for segmentIndex = 1:numOfSegments
            channelOffset = (channelIndex - 1) * numOfBands * numOfSegments;
            writeToIndex = channelOffset + (segmentIndex - 1) * numOfBands + numOfLabels;
            participantResult(movieIndex, 1 + writeToIndex:writeToIndex + numOfBands) = ...
                fftResult(movieIndex, channelIndex, segmentIndex, :);
        end
    end
end