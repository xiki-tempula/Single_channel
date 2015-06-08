function data = brute_force_sort(data, K)
X = [log(data.opentime); log(data.closetime)];
X_length = length(X);

data.Cost = zeros(1,K);
data.idx = zeros(K, X_length);

start = 1;
stop = X_length;

data.Cost(1) = sum(sum((X - mean(X, 2) * ones(1, X_length)).^2));
data.idx(1,:) = ones(1, X_length);

for i = 2:K
    fprintf('Fitting data to %u modes. \n', i)
    
    min_cost = Inf;
    for j = 1:(X_length -1)
        temp_start = sort([start, j]);
        temp_stop = sort([stop, j+1]);
        
        mode_number = length(temp_stop);
        
        trial_cost = 0;
        
        for k = 1:mode_number
            trial_data = X(:, temp_start(k): temp_stop(k));
            trial_length = temp_stop(k) - temp_start(k) + 1;
            trial_cost = trial_cost + sum(sum((trial_data...
                - mean(trial_data, 2)*ones(1, trial_length)).^2));
        end
        
        if trial_cost < min_cost
            min_cost = trial_cost;
            min_idx = j;
        end
    end
    
    data.Cost(i) = min_cost;
    
    start = sort([start, min_idx]);
    stop = sort([stop, min_idx+1]);
    
    for j = 1:i
        data.idx(i, start(j):stop(j)) = ones(1, (stop(j) - start(j) + 1)) * j;
    end
    
    %plot_Kmeans([X; data.eventtime], data.idx(i, :))
end
data.NormalisedCost = data.Cost / max(data.Cost);
    
           
    
    
    