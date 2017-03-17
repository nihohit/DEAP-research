function result = RunPWelch3D(data)
sizeOfData = size(data);
psd = zeros(sizeOfData(1), sizeOfData(2), sizeOfData(3)); 

a = figure('visible','off');
frequency=128;
for i = 1:sizeOfData(1)
    for j = 1 : sizeOfData(2)
        [X, frequencies] = pwelch(squeeze(data(i,j,:)), [],[],[],frequency);
        psd(i,j,:) = X;
    end
end

result = SignalToBands4D(psd, frequencies);
