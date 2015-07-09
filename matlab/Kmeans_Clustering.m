function data = Kmeans_Clustering(data, K, ~, repeat)

X = [log(data.opentime); log(data.closetime); data.eventtime];
means = mean(X,2);
STD = std(X,[],2);
X = (X - means * ones(1,size(X,2)))./(STD * ones(1,size(X,2)));
X = X';
silh_list = ones(K,1);
idx_list = ones(K, length(X));
cost = zeros(1, K);
for i = 1:K
    [idx, ~, sumd] = kmeans(X,i,...
                       'Replicates',repeat);

    cost(i) = sum(sumd);
    silh = silhouette(X,idx,'city');
    silh_list(i) = mean(silh);
    
    oldidx = idx;
    idx = [];


    for j = 1:length(unique(oldidx))
        idx = [idx ones(1, length(find(oldidx == oldidx(1)))) * j];
        oldidx(oldidx == oldidx(1)) = [];
    end
    idx_list(i,:) = idx;
end
PlotClusterResult(X, idx_list, means, STD)
data.Cost = cost;
data.NormalisedCost = cost ./ max(cost);
