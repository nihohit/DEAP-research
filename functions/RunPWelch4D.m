function result = RunPWelch4D(data)
sizeOfData = size(data);
psd = zeros(sizeOfData(1), sizeOfData(2), sizeOfData(3), 513); 

a = figure('visible','off');
frequency=128;
for i = 1:sizeOfData(1)
    for j = 1 : sizeOfData(2)
        x = squeeze(data(i,j,:,:)).';
        [X, frequencies] = pwelch(x, [],[],[],frequency);
        psd(i,j,:,:) = X';
    end
end

result = SignalToBands4D(psd, frequencies);