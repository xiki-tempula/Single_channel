function cost = computecost(X, centroids, idx)
cost = 0;

for i = 1:length(idx)
    cost = cost + (X(:,i) - centroids(:,idx(i))).^2;

end
cost = sum(cost(1:2));