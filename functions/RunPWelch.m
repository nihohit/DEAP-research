function result = RunPWelch( channelVector )
a = figure('visible','off');
frequency=128;
[X, frequencies] = pwelch(channelVector, [],[],[],frequency);
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

