function result = CleanData(array)
standardDeviations = 2*std(array);
meanValue = mean(array);

array(array > meanValue + standardDeviations)=NaN;
array(array < meanValue - standardDeviations)=NaN;
result = array;
