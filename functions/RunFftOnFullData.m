%This function receives the data for a single participant, permutes it so
%that the data of each channel will be the first dimension, runs
%FFT on it and returns the split bands values
function result = RunFftOnFullData(data)
a = figure('visible','off');
frequency=128;

nfft = 2^( nextpow2(length(data)) ); % Next power of 2 from length of channelVector
f = frequency/2*linspace(0,1,nfft/2+1);
X = fft(data,nfft);
X = X(1:nfft/2+1,:,:); % cut the vector in 2, and get the relevant half
permutedResult = permute(abs(X),[2,3,1]);
permutedResult = CleanData(permutedResult);
thetaMinIndex = find(f >= 4 , 1);
alphaMinIndex = find(f >= 8 , 1);
lowBetaMinIndex = find(f >= 16 , 1);
highBetaMinIndex = find(f >= 25 , 1);
gammaMinIndex = find(f >= 31 , 1);
gammaMaxIndex = find(f >= 45 , 1);

sizeOfResult = size(permutedResult);
result = zeros(sizeOfResult(1), sizeOfResult(2), 5);

for i = 1:sizeOfResult(1)
    for j = 1 : sizeOfResult(2)
        result(i,j,1) = nanmean(permutedResult(i,j,thetaMinIndex: alphaMinIndex-1)); %theta
        result(i,j,2) = nanmean(permutedResult(i,j,alphaMinIndex: lowBetaMinIndex-1,1)); %alpha
        result(i,j,3) = nanmean(permutedResult(i,j,lowBetaMinIndex: highBetaMinIndex-1,1)); %low beta
        result(i,j,4) = nanmean(permutedResult(i,j,highBetaMinIndex: gammaMinIndex-1,1)); %high beta
        result(i,j,5) = nanmean(permutedResult(i,j,gammaMinIndex: gammaMaxIndex-1)); % gamma
    end
end



