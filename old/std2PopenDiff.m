function PopenDiffCluster = std2PopenDiff(AmpCluster)
% Convert the standard deviation to Popen difference

PopenDiffCluster = AmpCluster * sqrt(12);
end

