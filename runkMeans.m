function [centroids, idx] = runkMeans(X, K, ...
                                      max_iters, show_process)
%RUNKMEANS runs the K-Means algorithm on data matrix X, where each column of X
%is a single example

% turn on feature scaling and mean normalisation
normalisation = true;

if ~normalisation
    means = zeros(size(X,2), 1);
    STD = ones(size(X,2), 1);
else
    means = mean(X,2);
    STD = std(X,[],2);
    X = (X - means * ones(1,size(X,2)))./(STD * ones(1,size(X,2)));
end

% Initialize values
global iters_count convergance
centroids = kMeansInitCentroids(X, K);
idx = zeros(1,size(X,2));
previous = zeros(2^K,length(idx));


% Run K-Means
fprintf('Start runing K-means.')
for i=1:max_iters
    
    % Output progress
    fprintf('.');
    
    % For each example in X, assign it to the closest centroid
    idx = findClosestCentroids(X, centroids);
    if length(unique(idx)) < K
        centroids = kMeansInitCentroids(X, K);
        idx = findClosestCentroids(X, centroids);
    else
        centroids = computeCentroids(X, idx, K);
    end
    
    if strcmp(show_process, 'iteration')
        plot_Kmeans(X, idx, centroids)
    end
    
    

    
    for j = 1:size(previous,1)
        if previous(j,:) == idx
            convergance = 1;
            iters_count = 0;
            break
        end
    end
    
    previous(1:end-1,:) = previous(2:end,:);
    previous(end,:) = idx;
    
    if convergance == 1
        break
    end
end
fprintf('\n')

if i == max_iters
    fprintf('Maxium number (%u) of iterations has been reached. \n', max_iters)
    iters_count = iters_count + 1;
    convergance = 0;
end

[idx, centroids] = sort_idx(idx, centroids);

centroids = centroids.*(STD*ones(1,K)) + means*ones(1,K);
    


end

