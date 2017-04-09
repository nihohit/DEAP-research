function result = RunNormalized3D(data, runFFT)

dataSize = size(data);
secondLength = dataSize(3) / 63;

baseline = data(:,:,1:secondLength*3);
video = data(:,:,secondLength*3:length(data));
if runFFT
    baseline = RunFFT3D(baseline);
    video = RunFFT3D(video);
else
    baseline = RunPWelch3D(baseline);
    video = RunPWelch3D(video);
end

result = zeros(dataSize(2), dataSize(3), 5);

for i = 1:dataSize(1) % movies
    for j = 1:dataSize(2) %channels
        for band = 1:5
            result(i,j,band) = video(i,j,band) / baseline(i,j,band);
        end
    end
end