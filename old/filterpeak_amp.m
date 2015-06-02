function filterpeak = filterpeak_amp(dwell, AmpCluster, peakCluster, threshold)
% Filter peak based one the difference in Popen, threshold = [upper lower]
% peakCluster is in arbitary unit. To convert to real time (* jump)

for i = 1:length(AmpCluster)
    compareupper = std2PopenDiff(AmpCluster{i}) > ...
            (threshold(1) * peak2PopenDiff(peakCluster{i}, dwell));
    while any(compareupper)
        Difference = find(compareupper, 1);
        AmpCluster{i}(Difference(1)) = [];
        peakCluster{i}(Difference(1)) = [];
        PopenDiffCluster_amp = std2PopenDiff(AmpCluster{i});
        PopenDiffCluster_peak = peak2PopenDiff(peakCluster{i}, dwell);
        compareupper = PopenDiffCluster_amp > ...
            (threshold(1) * PopenDiffCluster_peak);
    end
    
    comparelower = std2PopenDiff(AmpCluster{i}) < ...
            (threshold(2) * peak2PopenDiff(peakCluster{i}, dwell));
    while any(comparelower)
        Difference = find(comparelower, 1);
        AmpCluster{i}(Difference(1)) = [];
        peakCluster{i}(Difference(1)) = [];
        PopenDiffCluster_amp = std2PopenDiff(AmpCluster{i});
        PopenDiffCluster_peak = peak2PopenDiff(peakCluster{i}, dwell);
        comparelower = PopenDiffCluster_amp < ...
            (threshold(2) * PopenDiffCluster_peak);
    end
        
filterpeak = peakCluster;
end

