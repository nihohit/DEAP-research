function header = GetArffHeader(numOfChannels, numOfSegments)
% create the header for the .arff file.

header = '\n\n';
for channel = 1:numOfChannels
    for segment = 1:numOfSegments
        suffix = strcat(int2str(channel), '_', int2str(segment),' numeric\n');
        prefix = '@attribute ';
        theta = strcat(prefix,' Theta', suffix);
        alpha = strcat(prefix,' Alpha', suffix);
        lowBeta = strcat(prefix,' LowBeta', suffix);
        highBeta = strcat(prefix,' HighBeta', suffix);
        gamma = strcat(prefix,' Gamma', suffix);
        header = strcat(header, theta, alpha, lowBeta, highBeta, gamma);
    end
end
header = strcat(header, '@attribute class {-1,1}\n\n@data\n');

end

