function PopenStdArray = genPopenstdarray(dwell, interval, jump)
Popenarray = genPopenarray(dwell, interval, jump);
PopenStdArray = zeros(1, floor(sum(dwell)/jump));
start = ceil(interval / jump);
finish = floor((sum(dwell) - interval) / jump);
for i = start:finish
    PopenStdArray(i) = std(Popenarray(...
    i - floor(interval / 2 / jump): ...
    i + floor(interval / 2 / jump)));
end
end