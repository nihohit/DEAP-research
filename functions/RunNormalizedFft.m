function result = RunNormalizedFft(channelVector)
channelSize = size(channelVector);
secondLength = channelSize(1) / 63;

baseline = channelVector(1:secondLength*3,:);
video = channelVector(secondLength*3+1:length(channelVector));
baselineFFT = RunFft(baseline);
videoFFT = RunFft(video);

normalizedTheta = videoFFT(1) / baselineFFT(1);
normalizedAlpha = videoFFT(2) / baselineFFT(2);
normalizedLowBeta = videoFFT(3) / baselineFFT(3);
normalizedHighBeta = videoFFT(4) / baselineFFT(4);
normalizedGamma = videoFFT(5) / baselineFFT(5);

clear baselineFFT;
clear videoFFT;

result = [normalizedTheta normalizedAlpha normalizedLowBeta normalizedHighBeta normalizedGamma];

close all;