a = figure('visible','off');
participantResult = zeros(40,201);
for i = 1:40
    participantResult(i, :) = GetVideoVector(squeeze(data(i,:,:)),1);
end
csvwrite('../participant1.csv', participantResult);
close all;