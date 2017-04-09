function result = RunPWelch4D(data)
sizeOfData = size(data);

a = figure('visible','off');
frequency=128;
for i = 1:sizeOfData(1)
    for j = 1 : sizeOfData(2)
        x = squeeze(data(i,j,:,:)).';
        [X, frequencies] = pwelch(x, [],[],[],frequency);
        X = X';
        sizeOfResult = size(X);
        if (i ==1 && j == 1)
        	psd = zeros(sizeOfData(1), sizeOfData(2), sizeOfResult(1), sizeOfResult(2)); 
        end
        psd(i,j,:,:) = X;
    end
end

result = SignalToBands4D(psd, frequencies);