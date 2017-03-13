function result = CleanData4d(permutedArray)
result = permutedArray;
sizeOfArray = size(permutedArray);
for i = 1:size(sizeOfArray(1))
    for j = 1:size(sizeOfArray(2))
        for p = 1:size(sizeOfArray(2))
            internalArray = squeeze(permutedArray(i,j,p,:));
            standardDeviations = 2*std(internalArray);
            meanValue = mean(internalArray);
            
%            figure;
%            plot(internalArray);
            
            internalArray(internalArray > meanValue + standardDeviations)=NaN;
            internalArray(internalArray < meanValue - standardDeviations)=NaN;
            result(i,j,p,:) = internalArray;
            
%            figure;
%            plot(internalArray);
%            figure;
%            plot(squeeze(result(i,j,p,:)));
%            close all;
        end
    end
end
