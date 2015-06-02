function [x, y, amprange] = genOriginalSignal(data)
% Gnenerate original signal form data

dwell = data(4,:);
cumdwell = cumsum(dwell);
amp = data(3,:);
x = reshape(repmat(cumdwell,2,1),[1, size(cumdwell, 2) * 2]);
x = [0 x(1:end-1)];
y = reshape(repmat(amp,2,1),[1, size(amp, 2) * 2]);

GMModel = fitgmdist(amp.',2);
amprange = GMModel.mu;
end

