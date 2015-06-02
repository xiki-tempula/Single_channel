function peakcell = SplitPeak(filterpeak, DiffThreshold)
%Combine the filtered peaks together

CombinedPeak = cell2mat(filterpeak);
CombinedPeak = sort(CombinedPeak);
CombinedPeakDiff = diff(CombinedPeak);

if nargin < 2
    DiffThreshold = mean(CombinedPeakDiff);
end

peak = [1 find(CombinedPeakDiff > DiffThreshold)];

peakcell = cell(length(CombinedPeakDiff));
for i = 1:length(CombinedPeakDiff)
    peakcell{i} = CombinedPeak(peak(i) : peak(i+1));
end
end
