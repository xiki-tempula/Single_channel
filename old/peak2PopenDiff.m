function PopenDiffCluster = peak2PopenDiff(peakCluster, dwell)
%Calculate Popen difference from the peak 

overall = sum(dwell);
peak = [0 peakCluster overall];
PopenDiffCluster = zeros(1, length(peakCluster));
for i = 1:length(peakCluster)
    PopenDiffCluster(i) = abs(...
        calculatePopen(dwell,peak(i),peak(i + 1))...
        -...
        calculatePopen(dwell,peak(i + 1),peak(i + 2)));
end

end

