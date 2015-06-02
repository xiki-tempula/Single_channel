function Popenarray = genPopenarray(dwell, interval, jump)
Popenarray = zeros(1, floor(sum(dwell)/jump));
start = ceil(interval / 2 / jump);
finish = floor((sum(dwell) - interval / 2) / jump);
for i = start:finish
    Popenarray(i) = calculatePopen(dwell, ...
    i * jump - interval / 2, ...
    i * jump + interval / 2);
end
end