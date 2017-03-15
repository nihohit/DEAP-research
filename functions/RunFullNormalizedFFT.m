function result = RunFullNormalizedFFT(permutedArray)

dataSize = size(permutedArray);
secondLength = dataSize(1) / 63;

baseline = permutedArray(1:secondLength*3,:,:);
video = permutedArray(secondLength*3:length(permutedArray),:,:);
baselineFFT = RunFft(baseline);
videoFFT = RunFft(video);

result = zeros(dataSize(2), dataSize(3), 5);

for i = 1:dataSize(2) % movies
    for j = 1:dataSize(3) %channels
        
        for band = 1:5
            result(i,j,band) = videoFFT(i,j,band) - baselineFFT(i,j,band);
        end
    end
end