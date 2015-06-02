function Popen = calculatePopen(dwell, start, finish)
if start < 0
    if start > -0.0000001
        start = 0;
    else
        throw(MException('negative index',...
            'The start time for calculating Popen is negative'));
    end
end

dwell_time = [0 dwell];
cumdwell_time = cumsum(dwell_time);

startindex = find(cumdwell_time <= start);
startindex = startindex(end) + 1;
dwell_time(startindex) = cumdwell_time(startindex) - start;

endindex = find(cumdwell_time >= finish);
endindex = endindex(1);
dwell_time(endindex) = finish - cumdwell_time(endindex - 1);

if startindex == endindex
    dwell_time(startindex) = finish - start;
end

index = false(1,length(dwell_time));
index(startindex: endindex) = true;
index(2:2:end) = false;
opentime = dwell_time(index);

Popen = sum(opentime) / (finish - start);
end