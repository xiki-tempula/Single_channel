function cost = computecost(X, centroids, idx)
cost = 0;
time_weight = 1;
open_weight = 1;
close_weight = 1;
weight = [time_weight, open_weight, close_weight];
for i = 1:length(idx)
    cost = cost + weight * (X(:,i) - centroids(:,idx(i))).^2;

end