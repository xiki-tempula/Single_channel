function [centroids, idx] = runkMeans(X, initial_centroids, ...
                                      max_iters)
%RUNKMEANS runs the K-Means algorithm on data matrix X, where each column of X
%is a single example

% Initialize values
global iters_count convergance
K = size(initial_centroids, 2);
centroids = initial_centroids;
idx = zeros(1,size(X,2));
previous = idx;
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
    
    if previous == idx
        convergance = 1;
        iters_count = 0;
        break
    end
    previous = idx;
end
fprintf('\n')

if i == max_iters
    fprintf('Maxium number (%u) of iterations has been reached. \n', max_iters)
    iters_count = iters_count + 1;
    convergance = 0;
end

oldidx = idx;
oldcentroids = centroids;

idx = [];
centroids = [];

for i = 1:K
    centroids = [centroids oldcentroids(:,oldidx(1))];
    idx = [idx ones(1, length(find(oldidx == oldidx(1)))) * i];
    oldidx(oldidx == oldidx(1)) = [];
end


    


end

