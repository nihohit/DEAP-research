%This function receives the information of a given channel over a single
%video, and returns the band vector
function result = RunFft(channelVector)
a = figure('visible','off');
frequency=128;
%N=length(channelVector);
%ts=1/frequency;
%tmax=(N-1)*ts;
%t=0:ts:tmax;
%plot(t,x);  % plot time domain
nfft = 2^( nextpow2(length(channelVector)) ); % Next power of 2 from length of channelVector
f = frequency/2*linspace(0,1,nfft/2+1);
X = fft(channelVector,nfft);
X = X(1:nfft/2+1); % cut the vector in 2, and get the relevant half
logAbsX = log(abs(X));
figure;  
%plot(f,logAbsX); % plot freq domain
thetaMinIndex = find(f >= 4 , 1);
alphaMinIndex = find(f >= 8 , 1);
lowBetaMinIndex = find(f >= 16 , 1);
highBetaMinIndex = find(f >= 25 , 1);
gammaMinIndex = find(f >= 31 , 1);
gammaMaxIndex = find(f >= 45 , 1);
theta = mean(logAbsX(1, thetaMinIndex: alphaMinIndex-1));
alpha = mean(logAbsX(1, alphaMinIndex: lowBetaMinIndex-1));
lowBeta = mean(logAbsX(1, lowBetaMinIndex: highBetaMinIndex-1));
highBeta = mean(logAbsX(1, highBetaMinIndex: gammaMinIndex-1));
gamma = mean(logAbsX(1, gammaMinIndex: gammaMaxIndex-1));
result = [theta alpha lowBeta highBeta gamma];
