function result = RunPWelch3D(data)
sizeOfData = size(data);

a = figure('visible','off');
frequency=128;
for i = 1:sizeOfData(1)
    for j = 1 : sizeOfData(2)
        [X, frequencies] = pwelch(squeeze(data(i,j,:)), [],[],[],frequency);
        sizeOfResult = size(X);
        if (i ==1 && j == 1)
            psd = zeros(sizeOfData(1), sizeOfData(2), sizeOfResult(1)); 
        end
        psd(i,j,:) = X;
    end
end

 result = SignalToBands3D(psd, frequencies);

 