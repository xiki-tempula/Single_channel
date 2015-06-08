function data = Kmeans_Clustering_hw(data, K, max_iters, repeat, show_process)
global iters_count convergance weight


X = [log(data.opentime); log(data.closetime); data.eventtime];
%X = [data.opentime; data.closetime; data.eventtime];



cost = zeros(repeat,K);

sum_idx = zeros(K*repeat, length(X));
for a = 1:K
    fprintf('Fitting data to %u modes. \n', a)
    %figure(3);
    %clf;
    
    for b = 1:repeat
        convergance = 0;
        iters_count = 0;
        fprintf('Starting the %u attempt. \n', b)
        
        addweight = true;

        while addweight
            [centroids, idx] = runkMeans(X, a, ...
                                      max_iters, show_process);
            repeat_result = check_repeat(idx);
            if repeat_result == true
                weight(3) = weight(3)+1;
                fprintf('Weight for the event time is too small. Now becomes %u \n', weight(3))
            else
                addweight = false;
            end
            
            if idx ~= sort(idx)
                [idx, centroids] = sort_idx(idx, centroids);
            end
            
        end
        %{
        while convergance == 0
            [centroids, idx] = runkMeans(X, a, ...
                                      max_iters, show_process);
            if iters_count > 10
                disp('The convergance has been repeated for 10 times and will not converge.')
                
                break
            end
        end
        %}
        index = (a-1)*repeat + b;
        sum_idx(index,:) = idx;
        
        cost(b,a) = computecost(X, centroids, idx);
        
        %figure(3);
        %hold on
        %plot(b, cost(b,a), 'o')
        %hold off
        
        if strcmp(show_process, 'repeat')
            plot_Kmeans(X, idx, centroids)
        end
        

    end
    
end

[data.Cost, index] = min(cost);
data.NormalisedCost = data.Cost / max(data.Cost);
%plot(data.NormalisedCost)

data.idx = zeros(K, length(X));
for i = 1:K
    data.idx(i,:) = sum_idx((K-1) * repeat + index(i), :);
end


%PlotClusterResult(X, idx, means, STD)
%pause

    

