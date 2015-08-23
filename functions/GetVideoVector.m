function result = GetVideoVector(videoVector, labels)
a = figure('visible','off');

lengthInSeconds = 63;
irrelevantSeconds = 3;
relevantSeconds = lengthInSeconds - irrelevantSeconds;
frequencyPerSecond = length(squeeze(videoVector(1,:))) / lengthInSeconds;
amountOfSegments = 4;
segmentOverlap = 0.5;
beginFrom = irrelevantSeconds*frequencyPerSecond;
segmentLength = (relevantSeconds * frequencyPerSecond / amountOfSegments);
overlapSize = segmentLength * segmentOverlap;

result = zeros(1,644);
result(1,1:4) = labels;
for i = 1:32
    currentChannel = squeeze(videoVector(i,:));
    
    for segment = 0:amountOfSegments-1
       min = beginFrom + (segment * segmentLength);
       if(segment > 0)
          min = min - overlapSize;
       end
       max = beginFrom + ((segment + 1) * segmentLength) - 1;
       
       if(segment < amountOfSegments-2)
          max = max + overlapSize;
       end
       currentSegment = currentChannel(1,min:max);
       segmentResult = RunFft(currentSegment);
       writeToIndex = (((i-1)*amountOfSegments) + segment)*5 + 4;
       result(1, 1 + writeToIndex:writeToIndex + 5) = segmentResult;
    end
end