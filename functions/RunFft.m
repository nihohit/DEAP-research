%This function receives the information of a given channel over a single
%video, and returns the band vector
function result = RunFft(channelVector)
a = figure('visible','off');
fs=128;
N=length(channelVector);
ts=1/fs;
tmax=(N-1)*ts;
t=0:ts:tmax;
%plot(t,x);  % plot time domain
nfft = 2^( nextpow2(length(channelVector)) );
df = fs/nfft;
f = 0:df:fs/2;
X = fft(channelVector,nfft);
X = X(1:nfft/2+1);
absX = abs(X);
figure; 
% plot(f,absX); % plot freq domain
thetaMinIndex = find(f >= 4 , 1);
alphaMinIndex = find(f >= 8 , 1);
lowBetaMinIndex = find(f >= 16 , 1);
highBetaMinIndex = find(f >= 25 , 1);
gammaMinIndex = find(f >= 31 , 1);
gammaMaxIndex = find(f >= 45 , 1);
theta = mean(absX(1, thetaMinIndex: alphaMinIndex-1));
alpha = mean(absX(1, alphaMinIndex: lowBetaMinIndex-1));
lowBeta = mean(absX(1, lowBetaMinIndex: highBetaMinIndex-1));
highBeta = mean(absX(1, highBetaMinIndex: gammaMinIndex-1));
gamma = mean(absX(1, gammaMinIndex: gammaMaxIndex-1));
result = [theta alpha lowBeta highBeta gamma];
