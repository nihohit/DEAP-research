function result = GetVideoVector(dataVector, participantIndex, labels, numOfChannels, numOfBands)
a = figure('visible','off');

numberOfLabels = length(labels);

result = zeros(1, numOfBands * numOfChannels + numberOfLabels);
result(1, 1:numberOfLabels) = labels;
for channelIndex = 1:numOfChannels
       segmentResult = RunNormalizedFft(squeeze(dataVector(participantIndex,channelIndex,:)));
       writeToIndex = (channelIndex-1) * numOfBands + numberOfLabels;
       result(1, 1 + writeToIndex:writeToIndex + numOfBands) = segmentResult;
       clear segmentResult;
       %disp(sprintf('done channel %d', channelIndex));
end

close all;