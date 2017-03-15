function result = RunPWelch(data)

a = figure('visible','off');
frequency=128;
[X, frequencies] = pwelch(data, [],[],[],frequency);
logAbsX = log(abs(X));
figure; 
%plot(freq,logAbsX,'k','linewidth',1.2); % plot freq domain
thetaMinIndex = find(frequencies >= 4 , 1);
alphaMinIndex = find(frequencies >= 8 , 1);
lowBetaMinIndex = find(frequencies >= 16 , 1);
highBetaMinIndex = find(frequencies >= 25 , 1);
gammaMinIndex = find(frequencies >= 31 , 1);
gammaMaxIndex = find(frequencies >= 45 , 1);

theta = mean(logAbsX(thetaMinIndex: alphaMinIndex-1,1));
alpha = mean(logAbsX(alphaMinIndex: lowBetaMinIndex-1,1));
lowBeta = mean(logAbsX(lowBetaMinIndex: highBetaMinIndex-1,1));
highBeta = mean(logAbsX(highBetaMinIndex: gammaMinIndex-1,1));
gamma = mean(logAbsX(gammaMinIndex: gammaMaxIndex-1,1));

result = [theta alpha lowBeta highBeta gamma];
%plot(result);
end

data = permute(data,[4,1,2,3]);
a = figure('visible','off');
frequency=128;

nfft = 2^( nextpow2(length(data)) ); % Next power of 2 from length of channelVector
f = frequency/2*linspace(0,1,nfft/2+1);
X = fft(data,nfft);
X = X(1:nfft/2+1,:,:,:); % cut the vector in 2, and get the relevant half
permutedResult = permute(abs(X),[2,3,4,1]);
cleanedData = CleanData(permutedResult);
thetaMinIndex = find(f >= 4 , 1);
alphaMinIndex = find(f >= 8 , 1);
lowBetaMinIndex = find(f >= 16 , 1);
highBetaMinIndex = find(f >= 25 , 1);
gammaMinIndex = find(f >= 31 , 1);
gammaMaxIndex = find(f >= 45 , 1);

sizeOfResult = size(cleanedData);
result = zeros(sizeOfResult(1), sizeOfResult(2),sizeOfResult(3), 5);

for i = 1:sizeOfResult(1)
    for j = 1 : sizeOfResult(2)
        for p = 1 : sizeOfResult(3)
            result(i,j,p,1) = nanmean(permutedResult(i,j,p,thetaMinIndex: alphaMinIndex-1)); %theta
            result(i,j,p,2) = nanmean(permutedResult(i,j,p,alphaMinIndex: lowBetaMinIndex-1,1)); %alpha
            result(i,j,p,3) = nanmean(permutedResult(i,j,p,lowBetaMinIndex: highBetaMinIndex-1,1)); %low beta
            result(i,j,p,4) = nanmean(permutedResult(i,j,p,highBetaMinIndex: gammaMinIndex-1,1)); %high beta
            result(i,j,p,5) = nanmean(permutedResult(i,j,p,gammaMinIndex: gammaMaxIndex-1)); % gamma
        end
    end
end
