function result = SegmentData(data, numOfLabels, numOfChannels, numOfClips, numOfBands, numOfSegments, segmentLengthInSeconds)
figure('visible','off');

sizeOfData = size(data);
lengthInSeconds = 60;
overlapLengthInSeconds = (segmentLengthInSeconds * numOfSegments - lengthInSeconds) / (numOfSegments-1);

entriesPerSecond = sizeOfData(3) / lengthInSeconds;
segmentLength = segmentLengthInSeconds * entriesPerSecond;
overlapLength = round(overlapLengthInSeconds * entriesPerSecond);

result = zeros(sizeOfData(1),sizeOfData(2),numOfSegments,segmentLength);

for i = 1:sizeOfData(1)
    for j = 1:sizeOfData(2)
        beginFrom = 1;
        endAt = beginFrom + segmentLength - 1;
        for segment = 1:numOfSegments
            result(i,j,segment,:) =  data(i,j,beginFrom:endAt);
            beginFrom = endAt - overlapLength;
            endAt = beginFrom + segmentLength - 1;
        end
    end
end

close all;

end

