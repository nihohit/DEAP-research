function result = SignalToBands3D(frequencyDomainResult, f)
thetaMinIndex = find(f >= 4 , 1);
alphaMinIndex = find(f >= 8 , 1);
lowBetaMinIndex = find(f >= 16 , 1);
highBetaMinIndex = find(f >= 25 , 1);
gammaMinIndex = find(f >= 31 , 1);
gammaMaxIndex = find(f >= 45 , 1);

sizeOfResult = size(frequencyDomainResult);
result = zeros(sizeOfResult(1), sizeOfResult(2),sizeOfResult(3), 5);

for i = 1:sizeOfResult(1)
    for j = 1 : sizeOfResult(2)
            result(i,j,1) = nanmean(log(frequencyDomainResult(i,j,p,thetaMinIndex: alphaMinIndex-1)))); %theta
            result(i,j,2) = nanmean(log(frequencyDomainResult(i,j,p,alphaMinIndex: lowBetaMinIndex-1,1))); %alpha
            result(i,j,3) = nanmean(log(frequencyDomainResult(i,j,p,lowBetaMinIndex: highBetaMinIndex-1,1))); %low beta
            result(i,j,4) = nanmean(log(frequencyDomainResult(i,j,p,highBetaMinIndex: gammaMinIndex-1,1))); %high beta
            result(i,j,5) = nanmean(log(frequencyDomainResult(i,j,p,gammaMinIndex: gammaMaxIndex-1))); % gamma
    end
end
end

