function Popenarray = genPopenDiffArray(dwell, jump, interval)
Popenarray = zeros(1, floor(sum(dwell)/jump));
start = ceil(interval / jump);
finish = floor((sum(dwell) - interval) / jump);
for i = start:finish
    firstPopen = calculatePopen(dwell, i*jump - interval, i*jump);
    secondPopen = calculatePopen(dwell, i*jump, i*jump + interval);
    Popenarray(i) = abs(firstPopen - secondPopen);
end
end    

