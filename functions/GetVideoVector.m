function result = GetVideoVector(videoVector, videoLabel, participantsIndex)
a = figure('visible','off');
result = zeros(1,202);
result(1,1) = videoLabel;
result(1,2) = participantsIndex;
for i = 1:40
    currentChannel = squeeze(videoVector(i,:));
    channelResult = RunFft(currentChannel);
    result(1, 3 + ((i-1)*5):2 + i*5) = channelResult;
end

    