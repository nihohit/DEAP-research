function result = RunFftOnSegmentedData(dataVector, numOfLabels, numOfChannels, numOfClips, numOfBands, numOfSegments)
a = figure('visible','off');

sizeOfData = size(dataVector);
lengthInSeconds = 63;
irrelevantSeconds = 3;
relevantSeconds = lengthInSeconds - irrelevantSeconds;
segmentLengthInSeconds = relevantSeconds / numOfSegments;
entriesPerSecond = sizeOfData(3) / lengthInSeconds;
beginFrom = irrelevantSeconds*entriesPerSecond;
segmentLength = segmentLengthInSeconds * entriesPerSecond;

segmentedData = zeros(sizeOfData(1),sizeOfData(2),numOfSegments,segmentLength);

for i = 1:sizeOfData(1)
    for j = 1:sizeOfData(2)
        for segment = 0:numOfSegments-1
            min = beginFrom + (segment * segmentLength);
            max = beginFrom + ((segment + 1) * segmentLength) - 1;
            segmentedData(i,j,segment + 1,:) =  dataVector(i,j,min:max);
        end
    end
end

result = RunFft(segmentedData);
close all;

end

