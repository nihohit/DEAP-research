 function participantResult = participantsResults(participantIndex, numOfLabels, numOfChannels, numOfBands, ...
    numOfMovies, numOfSegments, runFFT, cleanData)

fileName = GetParticipantFilename(participantIndex);

load(fileName); %this loads the 'data' array.
a = figure('visible','off');

data = data(:,1:numOfChannels,:); %remove excess channels

participantResult = zeros(numOfMovies,numOfSegments * numOfBands * numOfChannels + numOfLabels); 

if(runFFT)
    transformResult = RunFFT3D(data);
else
    transformResult = RunPWelch3D(data);
end

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
                transformResult(movieIndex, channelIndex, segmentIndex, :);
        end
    end
end

if cleanData
    for movieIndex = 1:numOfMovies % movies
        participantResult(movieIndex, 5:numOfSegments * numOfBands * numOfChannels + numOfLabels) = ...
            CleanData(participantResult(movieIndex, numOfSegments * numOfBands * numOfChannels + numOfLabels));
    end 
end