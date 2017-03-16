function result = RunPWelch4D(data)
data = permute(data,[4,1,2,3]);

a = figure('visible','off');
frequency=128;
[X, frequencies] = pwelch(data, [],[],[],frequency);

permutedResult = permute(abs(X),[2,3,4,1]);
result = SignalToBands4D(permutedResult, frequencies);

end