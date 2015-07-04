function result = GetVideoVector(videoVector, videoLabel)
a = figure('visible','off');
result = zeros(1,201);
result(1,1) = videoLabel;
for i = 1:40
    currentChannel = squeeze(videoVector(i,:));
    channelResult = RunFft(currentChannel);
    result(1, 2 + ((i-1)*5):1 + i*5) = channelResult;
end

    