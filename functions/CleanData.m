function result = CleanData(data)
result = data;
sizeOfArray = size(data);
for i = 1:size(sizeOfArray(1))
    for j = 1:size(sizeOfArray(2))
        internalArray = squeeze(data(i,j,:));
        standardDeviations = 2*std(internalArray);
        meanValue = mean(internalArray);

%            figure;
%            plot(internalArray);

        internalArray(internalArray > meanValue + standardDeviations)=NaN;
        internalArray(internalArray < meanValue - standardDeviations)=NaN;
        result(i,j,:) = internalArray;

%            figure;
%            plot(internalArray);
%            figure;
%            plot(squeeze(result(i,j,p,:)));
%            close all;
    end
end
