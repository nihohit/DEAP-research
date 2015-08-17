function result = GetVideoVector(videoVector, labels)
a = figure('visible','off');
result = zeros(1,164);
result(1,1:4) = labels;
for i = 1:32
    currentChannel = squeeze(videoVector(i,:));
    channelResult = RunPWelch(currentChannel);
    result(1, 5 + ((i-1)*5):4 + i*5) = channelResult;
end