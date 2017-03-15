a = figure('visible','off');

currentExperiment = 'segmented_15Segments_removedDeviations';

numOfLabels = 4;
numOfChannels = 32;
numOfBands = 5;
numOfParticipants = 32;
numOfMovies = 40;
numOfSegments = 15;
resultArrayLength = numOfChannels * numOfBands * numOfSegments + 1;

%create .arff header
arffHeader = GetArffHeader(numOfChannels, numOfSegments);

%create files, write arffHeaders
for labelIndex = 1:numOfLabels 
    fileName = GetTargetFilename(labelIndex, currentExperiment);
    name = GetLabelName(labelIndex);
    fid = fopen(fileName, 'w');
    fprintf(fid, sprintf('@relation %s %s',name,arffHeader));
    fclose(fid);
end

for participantsIndex = 1:numOfParticipants
    participantResult =  participantsResults(participantsIndex, numOfLabels, numOfChannels, numOfBands, ...
        numOfMovies, numOfSegments);
    
    for labelIndex = 1:numOfLabels 
        fileName = GetTargetFilename(labelIndex, currentExperiment);
        % find all non-zero indices
        relevantResults = find(participantResult(:,labelIndex));
        numOfRelevantResults = length(relevantResults);
        relevantParticipantResult = zeros(numOfRelevantResults,resultArrayLength);
        
        % enter all non zero indices into array
        for i = 1:numOfRelevantResults
            relevantParticipantResult(i,resultArrayLength) = participantResult(relevantResults(i), labelIndex);
            relevantParticipantResult(i,1:resultArrayLength - 1) = participantResult(relevantResults(i), ...
                numOfLabels + 1:numOfChannels * numOfBands * numOfSegments + numOfLabels);
        end
        dlmwrite (fileName, relevantParticipantResult, '-append');

    end
    
    clear participantResult;
    
    disp(sprintf('written participant %d', participantsIndex));
end

close all;
