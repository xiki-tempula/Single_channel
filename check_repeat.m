function repeat = check_repeat(idx)
unique_idx = unique(idx);
if length(unique_idx) > 1
    start_idx = zeros(1,length(unique_idx));
    end_idx = zeros(1,length(unique_idx));
    for i = 1:length(unique_idx)
        find_idx = find(idx == unique_idx(i));
        start_idx(i) = find_idx(1);
        end_idx(i) = find_idx(end);
    end
    
    start_idx = start_idx(2:end);
    end_idx = end_idx(1:end-1);
    if sum(end_idx - (start_idx - 1)) == 0
        repeat = false;
    else
        repeat = true;
    end
else
    repeat = false;
end
        