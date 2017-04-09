a = figure('visible','off');

currentExperiment = 'normalized';

numOfLabels = 4;
numOfChannels = 32;
numOfBands = 5;
numOfParticipants = 32;
numOfMovies = 40;
numOfSegments = 1;
segmentLength = 20;
resultArrayLength = numOfChannels * numOfBands * numOfSegments + 1;

for experimentCase = 1:4
    runFFT = mod(experimentCase, 2) == 1;
    cleanData = experimentCase - 2 > 0;
    currentExperimentName = currentExperiment;
    if (runFFT)
        currentExperimentName = strcat(currentExperimentName, '_FFT');
    else
        currentExperimentName = strcat(currentExperimentName, '_PWelch');
    end
    
    if (cleanData)
        currentExperimentName = strcat(currentExperimentName, '_cleanData');
    else
        currentExperimentName = strcat(currentExperimentName, '_allData');
    end
    
    %create .arff header
    arffHeader = GetArffHeader(numOfChannels, numOfSegments);
    
    %create files, write arffHeaders
    for labelIndex = 1:numOfLabels
        fileName = GetTargetFilename(labelIndex, currentExperimentName);
        name = GetLabelName(labelIndex);
        fid = fopen(fileName, 'w');
        fprintf(fid, sprintf('@relation %s %s',name,arffHeader));
        fclose(fid);
    end
    
    for participantsIndex = 1:numOfParticipants
        participantResult =  participantsResults(participantsIndex, numOfLabels, numOfChannels, numOfBands, ...
            numOfMovies, numOfSegments, segmentLength, runFFT, cleanData);
        
        for labelIndex = 1:numOfLabels
            fileName = GetTargetFilename(labelIndex, currentExperimentName);
            % find all non-zero indices
            relevantResults = find(participantResult(:,labelIndex));
            numOfRelevantResults = length(relevantResults);
            relevantParticipantResult = zeros(numOfRelevantResults,resultArrayLength);
            % enter all non zero indices into array
            
            fid = fopen(fileName, 'at');
            for i = 1:numOfRelevantResults
                relevantParticipantResult(i,resultArrayLength) = participantResult(relevantResults(i), labelIndex);
                relevantParticipantResult(i,1:resultArrayLength - 1) = participantResult(relevantResults(i), ...
                    numOfLabels + 1:numOfChannels * numOfBands * numOfSegments + numOfLabels);
                resultAsString = num2str(relevantParticipantResult(i, :), '%.2f,');
                cleanedResultAsString = strrep(resultAsString, ' NaN', '?');
                cleanedResultAsString = strrep(cleanedResultAsString, '-inf', '?');
                cleanedResultAsString = strrep(cleanedResultAsString, 'inf', '?');
                cleanedResultAsString = strrep(cleanedResultAsString, '.00', '');
                fprintf (fid, cleanedResultAsString);
                fprintf (fid, '\n');
            end
            
            fclose(fid);
        end
        
        clear participantResult;
        
        disp(sprintf('written participant %d to %s', participantsIndex, currentExperimentName));
    end
    
    close all;
end
