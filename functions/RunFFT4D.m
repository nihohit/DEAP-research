%This function receives the data for a single participant with segmented data, permutes it so
%that the data of each channel will be the first dimension, runs
%FFT on it and returns the split bands values.
% data is assumed to be ordered thus: clip, channel, segment, signal.
function result = RunFFT4D(data)
data = permute(data,[4,1,2,3]);
a = figure('visible','off');
frequency=128;

nfft = 2^( nextpow2(length(data)) ); % Next power of 2 from length of channelVector
f = frequency/2*linspace(0,1,nfft/2+1);
X = fft(data,nfft);
X = X(1:nfft/2+1,:,:,:); % cut the vector in 2, and get the relevant half
permutedResult = permute(abs(X),[2,3,4,1]);

result = SignalToBands4D(permutedResult, f);

end