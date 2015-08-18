a = figure('visible','off');
header = '\n\n@attribute Theta_1 numeric\n@attribute Alpha_1 numeric\n@attribute LowBeta_1 numeric\n@attribute HighBeta_1 numeric\n@attribute Gamma_1 numeric\n@attribute Theta_2 numeric\n@attribute Alpha_2 numeric\n@attribute LowBeta_2 numeric\n@attribute HighBeta_2 numeric\n@attribute Gamma_2 numeric\n@attribute Theta_3 numeric\n@attribute Alpha_3 numeric\n@attribute LowBeta_3 numeric\n@attribute HighBeta_3 numeric\n@attribute Gamma_3 numeric\n@attribute Theta_4 numeric\n@attribute Alpha_4 numeric\n@attribute LowBeta_4 numeric\n@attribute HighBeta_4 numeric\n@attribute Gamma_4 numeric\n@attribute Theta_5 numeric\n@attribute Alpha_5 numeric\n@attribute LowBeta_5 numeric\n@attribute HighBeta_5 numeric\n@attribute Gamma_5 numeric\n@attribute Theta_6 numeric\n@attribute Alpha_6 numeric\n@attribute LowBeta_6 numeric\n@attribute HighBeta_6 numeric\n@attribute Gamma_6 numeric\n@attribute Theta_7 numeric\n@attribute Alpha_7 numeric\n@attribute LowBeta_7 numeric\n@attribute HighBeta_7 numeric\n@attribute Gamma_7 numeric\n@attribute Theta_8 numeric\n@attribute Alpha_8 numeric\n@attribute LowBeta_8 numeric\n@attribute HighBeta_8 numeric\n@attribute Gamma_8 numeric\n@attribute Theta_9 numeric\n@attribute Alpha_9 numeric\n@attribute LowBeta_9 numeric\n@attribute HighBeta_9 numeric\n@attribute Gamma_9 numeric\n@attribute Theta_10 numeric\n@attribute Alpha_10 numeric\n@attribute LowBeta_10 numeric\n@attribute HighBeta_10 numeric\n@attribute Gamma_10 numeric\n@attribute Theta_11 numeric\n@attribute Alpha_11 numeric\n@attribute LowBeta_11 numeric\n@attribute HighBeta_11 numeric\n@attribute Gamma_11 numeric\n@attribute Theta_12 numeric\n@attribute Alpha_12 numeric\n@attribute LowBeta_12 numeric\n@attribute HighBeta_12 numeric\n@attribute Gamma_12 numeric\n@attribute Theta_13 numeric\n@attribute Alpha_13 numeric\n@attribute LowBeta_13 numeric\n@attribute HighBeta_13 numeric\n@attribute Gamma_13 numeric\n@attribute Theta_14 numeric\n@attribute Alpha_14 numeric\n@attribute LowBeta_14 numeric\n@attribute HighBeta_14 numeric\n@attribute Gamma_14 numeric\n@attribute Theta_15 numeric\n@attribute Alpha_15 numeric\n@attribute LowBeta_15 numeric\n@attribute HighBeta_15 numeric\n@attribute Gamma_15 numeric\n@attribute Theta_16 numeric\n@attribute Alpha_16 numeric\n@attribute LowBeta_16 numeric\n@attribute HighBeta_16 numeric\n@attribute Gamma_16 numeric\n@attribute Theta_17 numeric\n@attribute Alpha_17 numeric\n@attribute LowBeta_17 numeric\n@attribute HighBeta_17 numeric\n@attribute Gamma_17 numeric\n@attribute Theta_18 numeric\n@attribute Alpha_18 numeric\n@attribute LowBeta_18 numeric\n@attribute HighBeta_18 numeric\n@attribute Gamma_18 numeric\n@attribute Theta_19 numeric\n@attribute Alpha_19 numeric\n@attribute LowBeta_19 numeric\n@attribute HighBeta_19 numeric\n@attribute Gamma_19 numeric\n@attribute Theta_20 numeric\n@attribute Alpha_20 numeric\n@attribute LowBeta_20 numeric\n@attribute HighBeta_20 numeric\n@attribute Gamma_20 numeric\n@attribute Theta_21 numeric\n@attribute Alpha_21 numeric\n@attribute LowBeta_21 numeric\n@attribute HighBeta_21 numeric\n@attribute Gamma_21 numeric\n@attribute Theta_22 numeric\n@attribute Alpha_22 numeric\n@attribute LowBeta_22 numeric\n@attribute HighBeta_22 numeric\n@attribute Gamma_22 numeric\n@attribute Theta_23 numeric\n@attribute Alpha_23 numeric\n@attribute LowBeta_23 numeric\n@attribute HighBeta_23 numeric\n@attribute Gamma_23 numeric\n@attribute Theta_24 numeric\n@attribute Alpha_24 numeric\n@attribute LowBeta_24 numeric\n@attribute HighBeta_24 numeric\n@attribute Gamma_24 numeric\n@attribute Theta_25 numeric\n@attribute Alpha_25 numeric\n@attribute LowBeta_25 numeric\n@attribute HighBeta_25 numeric\n@attribute Gamma_25 numeric\n@attribute Theta_26 numeric\n@attribute Alpha_26 numeric\n@attribute LowBeta_26 numeric\n@attribute HighBeta_26 numeric\n@attribute Gamma_26 numeric\n@attribute Theta_27 numeric\n@attribute Alpha_27 numeric\n@attribute LowBeta_27 numeric\n@attribute HighBeta_27 numeric\n@attribute Gamma_27 numeric\n@attribute Theta_28 numeric\n@attribute Alpha_28 numeric\n@attribute LowBeta_28 numeric\n@attribute HighBeta_28 numeric\n@attribute Gamma_28 numeric\n@attribute Theta_29 numeric\n@attribute Alpha_29 numeric\n@attribute LowBeta_29 numeric\n@attribute HighBeta_29 numeric\n@attribute Gamma_29 numeric\n@attribute Theta_30 numeric\n@attribute Alpha_30 numeric\n@attribute LowBeta_30 numeric\n@attribute HighBeta_30 numeric\n@attribute Gamma_30 numeric\n@attribute Theta_31 numeric\n@attribute Alpha_31 numeric\n@attribute LowBeta_31 numeric\n@attribute HighBeta_31 numeric\n@attribute Gamma_31 numeric\n@attribute Theta_32 numeric\n@attribute Alpha_32 numeric\n@attribute LowBeta_32 numeric\n@attribute HighBeta_32 numeric\n@attribute Gamma_32 numeric\n@attribute class {-1,1}\n\n@data\n';

%create files, write headers
for labelIndex = 1:4 
    fileName = GetFilename(labelIndex);
    name = GetLabelName(labelIndex);
    fid = fopen(fileName, 'w');
    fprintf(fid, sprintf('@relation %s %s',name,header));
    fclose(fid);
end

for participantsIndex = 1:32
    
    participantResult =  participantsResults(participantsIndex);
    
    for labelIndex = 1:4 
        fileName = GetFilename(labelIndex);
        % find all non-zero indices
        relevantResults = find(participantResult(:,labelIndex));
        numOfRelevantResults = length(relevantResults);
        relevantParticipantResult = zeros(numOfRelevantResults,161);
        
        % enter all non zero indices into array
        for i = 1:numOfRelevantResults
            relevantParticipantResult(i,161) = participantResult(relevantResults(i), labelIndex);
            relevantParticipantResult(i,1:160) = participantResult(relevantResults(i), 5:164);
        end
        dlmwrite (fileName, relevantParticipantResult, '-append');
    end
end

close all;