function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

global weight

% Set K
K = size(centroids, 2);


idx = zeros(1, size(X,2));




addweight = true;

while addweight
    for a = 1:size(X,2)
        J = zeros(1,K);
        for b = 1:K
            J(1,b) = weight * (X(:,a)-centroids(:,b)).^2;
        end
        [M idx(a)] = min(J);       
    end
    
    if numel(idx) == 0
        pass
    end
    


    
    repeat = check_repeat(idx);
    if repeat == true
        weight(3) = weight(3)+1;
        fprintf('Weight for the event time is too small. Now becomes %u \n', weight(3))
    else
        addweight = false;
    end
    
    if idx ~= sort(idx)
        [idx, centroids] = sort_idx(idx, centroids);
    end
    
end







% =============================================================



