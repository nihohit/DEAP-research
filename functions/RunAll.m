a = figure('visible','off');

numOfLabels = 4;
numOfChannels = 32;
numOfBands = 5;
numOfParticipants = 32;
numOfMovies = 40;
numOfSegments = 15;
resultArrayLength = numOfChannels * numOfBands * numOfSegments + 1;

arffHeader = '\n\n';

for channel = 1:numOfChannels
    for segment = 1:numOfSegments
        suffix = strcat(int2str(channel), '_', int2str(segment),' numeric\n');
        prefix = '@attribute ';
        theta = strcat(prefix,' Theta', suffix);
        alpha = strcat(prefix,' Alpha', suffix);
        lowBeta = strcat(prefix,' LowBeta', suffix);
        highBeta = strcat(prefix,' HighBeta', suffix);
        gamma = strcat(prefix,' Gamma', suffix);
        arffHeader = strcat(arffHeader, theta, alpha, lowBeta, highBeta, gamma);
    end
end

arffHeader = strcat(arffHeader, '@attribute class {-1,1}\n\n@data\n');

%create files, write arffHeaders
for labelIndex = 1:numOfLabels 
    fileName = GetFilename(labelIndex);
    name = GetLabelName(labelIndex);
    fid = fopen(fileName, 'w');
    fprintf(fid, sprintf('@relation %s %s',name,arffHeader));
    fclose(fid);
end

for participantsIndex = 1:numOfParticipants
    
    participantResult =  participantsResults(participantsIndex, numOfLabels, numOfChannels, numOfBands, ...
        numOfMovies, numOfSegments);
    
    for labelIndex = 1:numOfLabels 
        fileName = GetFilename(labelIndex);
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
