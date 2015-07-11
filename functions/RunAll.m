a = figure('visible','off');
header = 'class,user,Theta_1,Alpha_1,LowBeta_1,HighBeta_1,Gamma_1,Theta_2,Alpha_2,LowBeta_2,HighBeta_2,Gamma_2,Theta_3,Alpha_3,LowBeta_3,HighBeta_3,Gamma_3,Theta_4,Alpha_4,LowBeta_4,HighBeta_4,Gamma_4,Theta_5,Alpha_5,LowBeta_5,HighBeta_5,Gamma_5,Theta_6,Alpha_6,LowBeta_6,HighBeta_6,Gamma_6,Theta_7,Alpha_7,LowBeta_7,HighBeta_7,Gamma_7,Theta_8,Alpha_8,LowBeta_8,HighBeta_8,Gamma_8,Theta_9,Alpha_9,LowBeta_9,HighBeta_9,Gamma_9,Theta_10,Alpha_10,LowBeta_10,HighBeta_10,Gamma_10,Theta_11,Alpha_11,LowBeta_11,HighBeta_11,Gamma_11,Theta_12,Alpha_12,LowBeta_12,HighBeta_12,Gamma_12,Theta_13,Alpha_13,LowBeta_13,HighBeta_13,Gamma_13,Theta_14,Alpha_14,LowBeta_14,HighBeta_14,Gamma_14,Theta_15,Alpha_15,LowBeta_15,HighBeta_15,Gamma_15,Theta_16,Alpha_16,LowBeta_16,HighBeta_16,Gamma_16,Theta_17,Alpha_17,LowBeta_17,HighBeta_17,Gamma_17,Theta_18,Alpha_18,LowBeta_18,HighBeta_18,Gamma_18,Theta_19,Alpha_19,LowBeta_19,HighBeta_19,Gamma_19,Theta_20,Alpha_20,LowBeta_20,HighBeta_20,Gamma_20,Theta_21,Alpha_21,LowBeta_21,HighBeta_21,Gamma_21,Theta_22,Alpha_22,LowBeta_22,HighBeta_22,Gamma_22,Theta_23,Alpha_23,LowBeta_23,HighBeta_23,Gamma_23,Theta_24,Alpha_24,LowBeta_24,HighBeta_24,Gamma_24,Theta_25,Alpha_25,LowBeta_25,HighBeta_25,Gamma_25,Theta_26,Alpha_26,LowBeta_26,HighBeta_26,Gamma_26,Theta_27,Alpha_27,LowBeta_27,HighBeta_27,Gamma_27,Theta_28,Alpha_28,LowBeta_28,HighBeta_28,Gamma_28,Theta_29,Alpha_29,LowBeta_29,HighBeta_29,Gamma_29,Theta_30,Alpha_30,LowBeta_30,HighBeta_30,Gamma_30,Theta_31,Alpha_31,LowBeta_31,HighBeta_31,Gamma_31,Theta_32,Alpha_32,LowBeta_32,HighBeta_32,Gamma_32,Theta_33,Alpha_33,LowBeta_33,HighBeta_33,Gamma_33,Theta_34,Alpha_34,LowBeta_34,HighBeta_34,Gamma_34,Theta_35,Alpha_35,LowBeta_35,HighBeta_35,Gamma_35,Theta_36,Alpha_36,LowBeta_36,HighBeta_36,Gamma_36,Theta_37,Alpha_37,LowBeta_37,HighBeta_37,Gamma_37,Theta_38,Alpha_38,LowBeta_38,HighBeta_38,Gamma_38,Theta_39,Alpha_39,LowBeta_39,HighBeta_39,Gamma_39,Theta_40,Alpha_40,LowBeta_40,HighBeta_40,Gamma_40\n';

%create files, write headers
for labelIndex = 1:4 
    fileName = GetFilename(labelIndex);
    fid = fopen(fileName, 'w');
    fprintf(fid, header);
    fclose(fid);
end

for participantsIndex = 1:32
    
    participantResult =  participantsResults(participantsIndex);
    
    for labelIndex = 1:4 
        fileName = GetFilename(labelIndex);
        % find all non-zero indices
        relevantResults = find(participantResult(:,labelIndex));
        numOfRelevantResults = length(relevantResults);
        relevantParticipantResult = zeros(numOfRelevantResults,202);
        
        % enter all non zero indices into array
        for i = 1:numOfRelevantResults
            relevantParticipantResult(i,1) = participantResult(relevantResults(i), labelIndex);
            relevantParticipantResult(i,2) = participantsIndex;
            relevantParticipantResult(i,3:202) = participantResult(relevantResults(i), 5:204);
        end
        dlmwrite (fileName, relevantParticipantResult, '-append');
    end
end

close all;