function [idx, cost] = brute_force(X)
X_length = length(X);
Combinations  = combnk(1:X_length-1, 2);
Combinations_number = size(Combinations, 1);
min_cost = Inf;
start = [ones(Combinations_number, 1), Combinations + 1];
stop = [Combinations, ones(Combinations_number, 1) * X_length];
    
for j = 1:Combinations_number
    trial_cost = 0;
    trial_number = size(start,2);
    for k = 1:trial_number
        trial_data = X(:, start(j, k): stop(j, k));
        trial_length = stop(j, k) - start(j, k) + 1;
        trial_cost = trial_cost + sum(sum((trial_data...
            - mean(trial_data, 2)*ones(1, trial_length)).^2));
    end
    if trial_cost < min_cost
        min_cost = trial_cost;
        min_idx = j;
    end
end
    
cost = min_cost;
idx = Combinations(min_idx,:);


