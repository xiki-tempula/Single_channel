function data = Kmeans_Clustering_hw(data, K, max_iters, repeat, show_process)
global iters_count convergance
iters_count = 0;
convergance = 0;

X = [log(data.opentime); log(data.closetime); data.eventtime];

% turn on feature scaling and mean normalisation
normalisation = false;

if ~normalisation
    means = zeros(size(X,2), 1);
    STD = ones(size(X,2), 1);
else
    means = mean(X,2);
    STD = std(X,[],2);
    X = (X - means * ones(1,size(X,2)))./(STD * ones(1,size(X,2)));
end

cost = zeros(repeat,K);

data.idx = zeros(K*repeat, length(X));
for a = 1:K
    fprintf('Fitting data to %u modes. \n', a)
    for b = 1:repeat
        convergance = 0;
        fprintf('Starting the %u attempt. \n', b)
        initial_centroids = kMeansInitCentroids(X, a);
        [centroids, idx] = runkMeans(X, initial_centroids, ...
                                      max_iters, show_process);
        while convergance == 0
            initial_centroids = kMeansInitCentroids(X, a);
            [centroids, idx] = runkMeans(X, initial_centroids, ...
                                      max_iters, show_process);
            if iters_count > 10
                disp('The convergance has been repeated for 10 times and will not converge.')
                pause
            end
        end
        
        if strcmp(show_process, 'repeat')
            plot_Kmeans(X, idx, centroids)
        end
        
        index = (a-1)*repeat + b;
        data.idx(index,:) = idx;
        cost(b,a) = computecost(X, centroids, idx);
    end
        
end
PlotClusterResult(X, data.idx, means, STD)
%pause
data.Cost = cost;
data.CostStd = std(cost);
data.CostMu = mean(cost);
data.NormalisedCostMu = data.CostMu ./ max(data.CostMu);
data.NormalisedCostStd = data.CostStd ./ max(data.CostMu);

    

