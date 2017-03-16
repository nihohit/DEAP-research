function result = SignalToBands4D(frequencyDomainResult, f)
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
        for p = 1 : sizeOfResult(3)
            result(i,j,p,1) = nanmean(frequencyDomainResult(i,j,p,thetaMinIndex: alphaMinIndex-1)); %theta
            result(i,j,p,2) = nanmean(frequencyDomainResult(i,j,p,alphaMinIndex: lowBetaMinIndex-1,1)); %alpha
            result(i,j,p,3) = nanmean(frequencyDomainResult(i,j,p,lowBetaMinIndex: highBetaMinIndex-1,1)); %low beta
            result(i,j,p,4) = nanmean(frequencyDomainResult(i,j,p,highBetaMinIndex: gammaMinIndex-1,1)); %high beta
            result(i,j,p,5) = nanmean(frequencyDomainResult(i,j,p,gammaMinIndex: gammaMaxIndex-1)); % gamma
        end
    end
end
end

