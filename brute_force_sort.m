function data = brute_force_sort(data, K)
X = [log(data.opentime); log(data.closetime)];
X_length = length(X);

data.Cost = zeros(1,K);
data.idx = zeros(K, X_length);

start = 1;
stop = X_length;

data.Cost(1) = sum(sum((X - repmat(mean(X, 2), 1, X_length)).^2));
data.idx(1,:) = ones(1, X_length);

normalisation = zeros(1,K);
normalisation(1) = data.Cost(1);
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
                - repmat(mean(trial_data, 2), 1, trial_length)).^2));
        end
        
        if trial_cost < min_cost
            min_cost = trial_cost;
            min_idx = j;
        end
    end
    

end



for i = 2:K
    temp_width = floor(X_length / i);
    temp_X = X(:,1:temp_width*i);
    temp_X = reshape(temp_X, [2, temp_width, i]);
    temp_X = (temp_X - repmat(mean(temp_X, 2), 1, temp_width, 1)).^2;
    normalisation(i) = sum(sum(sum(temp_X)));
end

normalisation = normalisation(1) - normalisation;
normalised_cost = data.Cost(1) - data.Cost;
data.Normaliseddiff = normalised_cost - normalisation;

data.Cost = data.Cost / data.Cost(1);
    
    
    