function [AmpCluster, peakCluster] = stdpeak(stdMatrix, startInterval, jump, threshold)
Matrixsize = size(stdMatrix);
AmpCluster = cell(Matrixsize(1));
peakCluster = cell(Matrixsize(1));
for i = 1:Matrixsize(1)
    [PopenDiffAmp, peak] = findpeaks(stdMatrix(i,:), ...
    'MinPeakDistance', (startInterval / jump + (i - 1)) * 2 * threshold);
    AmpCluster{i} = PopenDiffAmp;
    peakCluster{i} = peak * jump;
end
end
