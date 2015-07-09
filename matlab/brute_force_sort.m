function data = brute_force_sort(data, K)
X = [log(data.opentime); log(data.closetime)];
X_length = length(X);

data.Cost = zeros(1,K + 5);
data.idx = zeros(K, X_length);

start = 1;
stop = X_length;

%data.Cost(1) = sum(sum((X - repmat(mean(X, 2), 1, X_length)).^2));
data.Cost(1) = sum(var(X,0,2)) * (X_length-1);
data.idx(1,:) = ones(1, X_length);

normalisation = zeros(1,K + 5);
normalisation(1) = data.Cost(1);




for i = 2:K + 5
    fprintf('Fitting data to %u modes. \n', i)
    
    min_cost = Inf;
    for j = 1:(X_length -1)
        temp_start = sort([start, j+1]);
        temp_stop = sort([stop, j]);
        
        mode_number = length(temp_stop);
        
        trial_cost = 0;
        
        for k = 1:mode_number
            if temp_start(k) < temp_stop(k)
                trial_data = X(:, temp_start(k): temp_stop(k));
                trial_length = temp_stop(k) - temp_start(k) + 1;
                trial_cost = trial_cost + sum(var(trial_data,0,2)) * (trial_length-1);
            end
        end

        if trial_cost < min_cost
            min_cost = trial_cost;
            min_idx = j;
        end
        
        normalisation(i) = normalisation(i) + trial_cost;
    end
    normalisation(i) = normalisation(i) / (X_length -1);
    data.Cost(i) = min_cost;
    
    start = sort([start, min_idx + 1]);
    stop = sort([stop, min_idx]);
    
    
    if i <= K
        for j = 1:i
            data.idx(i, start(j):stop(j)) = ones(1, (stop(j) - start(j) + 1)) * j;
        end

        %plot_Kmeans([X; data.eventtime], data.idx(i, :))
        
    end
    
    

end

%{
for i = 2:K
    temp_width = floor(X_length / i);
    temp_X = X(:,1:temp_width*i);
    temp_X = reshape(temp_X, [2, temp_width, i]);
    temp_X = (temp_X - repmat(mean(temp_X, 2), 1, temp_width, 1)).^2;
    normalisation(i) = sum(sum(sum(temp_X)));
end

%}
disp(data.Cost)
disp(normalisation)
data.normalisation = normalisation / X_length;

normalisation = normalisation(1) - normalisation;
normalised_cost = data.Cost(1) - data.Cost;

data.Normaliseddiff = (normalised_cost - normalisation) / X_length;

data.normalisation_mu = mean(data.Normaliseddiff(K+1: K+5));
data.normalisation_std = std(data.Normaliseddiff(K+1: K+5));

data.Normaliseddiff = data.Normaliseddiff(1:K);
data.Cost = data.Cost(1:K);
data.normalisation = data.normalisation(1:K);

data.Cost = data.Cost / X_length;

data.mode_number = elbow_search(data.Cost);

%{
data.normalisation = data.normalisation - min(data.Cost);
data.Cost = data.Cost - min(data.Cost);
data.normalisation = data.normalisation / max(data.Cost);
data.Cost = data.Cost / max(data.Cost);
%}

%{
min_number_std = ceil((max(data.Normaliseddiff(data.mode_number+1:end))...
    - data.normalisation_mu) / data.normalisation_std);
max_number_std = floor((max(data.Normaliseddiff(2:data.mode_number))...
    - data.normalisation_mu) / data.normalisation_std);+
%}
data.probability = ...
    mean(data.Normaliseddiff(2:data.mode_number)) /...
    mean(data.Normaliseddiff(data.mode_number+1:end));

if isinf(data.probability)
    pass
end
if data.probability <= 3
    data.mode_number = 1;
end
fprintf('Quotient for heterogenity id %f. \n', data.probability)

%fprintf('Number of stds min %u max %u range %f. \n',...
%    min_number_std, max_number_std, max_number_std/min_number_std)



    
    