function peakarray = combinePeak(peakcell, startInterval, endInterval, jump, threshold)
%combine Popen based on the number of peaks in the matrix

peakarray = [];
thresholdNo = (endInterval - startInterval) / jump * threshold;
for i = 1:length(peakcell)
    if length(peakcell{i}) > thresholdNo
        peakarray = [peakarray mean(peakcell{i})];
    end
end
end

