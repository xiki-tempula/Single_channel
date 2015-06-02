function PopenMatrix = genPopenMatrix(dwell, startInterval, endInterval, jump)
global progressname progress
progressname = 'Generating STD matirx: ';
progress = 0;

PopenMatrix = zeros(...
floor((endInterval - startInterval) / jump) + 1, ...
floor(sum(dwell) / jump));

Matrixlength = floor((endInterval - startInterval) / jump);

for start = 0: Matrixlength
    progress = start / Matrixlength;
    PopenMatrix(start + 1,:) = ...
    genPopenstdarray(dwell, startInterval + start*jump, jump);
    disp([progressname num2str(progress * 100) '%'])
end
disp('Matrix creating complete')
end