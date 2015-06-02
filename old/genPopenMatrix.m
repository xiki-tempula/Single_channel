function PopenMatrix = genPopenMatrix(dwell, startInterval, endInterval, jump)
PopenMatrix = zeros(...
floor((endInterval - startInterval) / jump) + 1, ...
floor(sum(dwell) / jump));

for start = 0: floor((endInterval - startInterval) / jump)
    PopenMatrix(start + 1,:) = ...
    genPopenstdarray(dwell, startInterval + start*jump, jump);
end
end
