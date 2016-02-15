function result = CleanData(permutedArray)
result = permutedArray;
sizeOfArray = size(permutedArray);
for i = 1:size(sizeOfArray(1))
    for j = 1:size(sizeOfArray(2))
        internalArray = squeeze(permutedArray(i,j,:));
        standardDeviations = 2*std(internalArray);
        meanValue = mean(internalArray);
        
        figure;
        plot(internalArray);
        
        internalArray(internalArray > meanValue + standardDeviations)=NaN; 
        internalArray(internalArray < meanValue - standardDeviations)=NaN;
        result(i,j,:) = internalArray;
        
        figure;
        plot(internalArray);
        figure;
        plot(squeeze(result(i,j,:)));
        close all;
    end
end

  