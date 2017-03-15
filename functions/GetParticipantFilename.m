function fileName = GetParticipantFilename(participantIndex)

if participantIndex < 10
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s0', num2str(participantIndex), '.mat');
else
    fileName = strcat('C:\Users\Shachar\Desktop\data_preprocessed_matlab\s', num2str(participantIndex), '.mat');
end