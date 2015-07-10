a = figure('visible','off');
index = 2;
validValues = find(labels(:,index) > 6 | labels(:,index) < 4);
numberOfValid = length(validValues);
participantResult = zeros(numberOfValid+1,201);
participantResult(1,1) = 'class';
for i = 1:40
    participantResult(1,2+(i-1)*5) = 'ch'+i+'_Theta';
    participantResult(1,3+(i-1)*5) = 'ch'+i+'_Alpha';
    participantResult(1,4+(i-1)*5) = 'ch'+i+'_LowBeta';
    participantResult(1,5+(i-1)*5) = 'ch'+i+'_HighBeta';
    participantResult(1,6+(i-1)*5) = 'ch'+i+'_Gamma';
end

for i = 1:numberOfValid
    label = 1;
    if(labels(validValues(i),index) < 4)
        label = -1;
    end
    participantResult(i+1, :) = GetVideoVector(squeeze(data(validValues(i),:,:)),label);
end
csvwrite('participant1.csv', participantResult);
close all;