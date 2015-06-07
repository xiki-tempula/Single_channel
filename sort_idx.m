function [idx, centroids] = sort_idx(idx, centroids)
if length(unique(idx)) > 1
    K = size(centroids, 2);
    
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
    