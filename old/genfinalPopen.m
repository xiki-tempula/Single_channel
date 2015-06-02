function [x, y] = genfinalPopen(dwell, peak)
% Generate the final Popen 
Peak1 = [0 peak];
Peak2 = [peak sum(dwell)];
Popenarray = zeros(1, length(Peak1));
for i = 1:length(Peak1)
    Popenarray(i) = calculatePopen(dwell, Peak1(i), Peak2(i));
end
y = reshape(repmat(Popenarray,2,1),[1, size(Popenarray, 2) * 2]);
x = reshape(repmat(peak,2,1),[1, size(peak, 2) * 2]);
x = [0 x sum(dwell)];
end

