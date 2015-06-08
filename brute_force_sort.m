function data = brute_force_sort(data, K)
X = [log(data.opentime); log(data.closetime)];
X_length = length(X);

data.Cost = zeros(1,K);
data.idx = zeros(K, X_length);

for i = 1:K
    fprintf('Fitting data to %u modes. \n', i)
    Combinations  = combnk(1:X_length - 1, i-1);
    if i == 1
        Combinations_number = 1;
    else
        Combinations_number = size(Combinations,1);
    end
    min_cost = Inf;
    start = [ones(Combinations_number, 1), Combinations];
    stop = [Combinations + 1, ones(Combinations_number, 1) * X_length];
    
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
    
    min_start = start(min_idx,:);
    min_stop = stop(min_idx,:);
    
    for j = 1:i
        data.idx(i, min_start(j):min_stop(j)) = ones(1, (min_stop(j) - min_start(j) + 1)) * j;
    end
end
data.NormalisedCost = data.Cost / max(data.Cost);
    
           
    
    
    