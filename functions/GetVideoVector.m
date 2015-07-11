function result = GetVideoVector(videoVector, labels)
a = figure('visible','off');
result = zeros(1,204);
result(1,1:4) = labels;
for i = 1:40
    currentChannel = squeeze(videoVector(i,:));
    channelResult = RunFft(currentChannel);
    result(1, 5 + ((i-1)*5):4 + i*5) = channelResult;
end

    