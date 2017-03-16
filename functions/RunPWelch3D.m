function result = RunPWelch3D(data)
data = permute(data,[3,1,2]);

a = figure('visible','off');
frequency=128;
[X, frequencies] = pwelch(data, [],[],[],frequency);

permutedResult = permute(abs(X),[2,3,1]);
result = SignalToBands4D(permutedResult, frequencies);
