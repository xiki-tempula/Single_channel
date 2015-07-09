function result = multiply_analysis(DataStructure, namearg, plotoriginal)

% Idetify the input pattern
if isfield(DataStructure, 'summary')
    % Check whether the input is a structure with multiply patches
    patch_name = fieldnames(DataStructure);
elseif isfield(DataStructure, 'Cluster')
    % The input is only one patch with multiply clusters.
    patch_name = {'summary', 'patch'};
    DataStructure = struct('summary', [], 'patch', DataStructure);
else
    patch_name = {'summary', 'patch'};
    DataStructure = struct('Cluster', DataStructure);
    DataStructure = struct('summary', [], 'patch', DataStructure);
end

%initialising the parameter
if strcmp('popen_dist', namearg)
    popen_list = [];
elseif strcmp('probability', namearg)
    probability_array = [];
elseif strcmp('maxmin_open/close', namearg)
    maxopen = 0;
    maxclose = 0;
    minopen = Inf;
    minclose = Inf;
elseif strcmp('total_close', namearg)
    total_close = [];
end
result = [];

% Doing the analysis
for i = 2:length(patch_name)
    cluster_data = DataStructure.(patch_name{i}).Cluster;
    for j = 1:length(cluster_data)
        cluster_detail = cluster_data(j);
        if nargin > 2
            if plotoriginal == true
            plot_original_data(cluster_detail)
            end
        end
        
        if strcmp('cost_function', namearg)
            mode_number = cluster_detail.mode_number;
            figure(3)
            clf;
            subplot(2,1,1)
            hold on
            if (length(patch_name) == 2) && (length(cluster_data) == 1)
                plot(1:length(cluster_detail.normalisation),...
                    cluster_detail.normalisation)
                plot(mode_number, cluster_detail.normalisation(mode_number), 'o')
            end
            plot(1:length(cluster_detail.Cost),...
                cluster_detail.Cost)
            
            plot(mode_number, cluster_detail.Cost(mode_number), 'o')
            hold off
            subplot(2,1,2)
            hold on
            
            plot(2:length(cluster_detail.Normaliseddiff),...
                cluster_detail.Normaliseddiff(2:end))
            plot(mode_number, cluster_detail.Normaliseddiff(mode_number), 'o')
            plot(2:10, ones(1,9) * cluster_detail.normalisation_mu)
            plot(2:10, ones(1,9) * (cluster_detail.normalisation_mu...
                + 5*cluster_detail.normalisation_std))
            
            plot(2:10, ones(1,9) * (cluster_detail.normalisation_mu...
                + 25* cluster_detail.normalisation_std))
            
            
            hold off
            
        elseif strcmp('open_close_distrubition', namearg)
            plotopenclose(cluster_detail)
        elseif strcmp('popen_dist', namearg)
            popen_list = [popen_list cluster_detail.totalPopen];
        elseif strcmp('probability', namearg)
            probability_array = [probability_array, cluster_detail.probability];
        elseif strcmp('maxmin_open/close', namearg)
            if maxopen < max(cluster_detail.opentime)
                maxopen = max(cluster_detail.opentime);
            end
            if maxclose < max(cluster_detail.closetime)
                maxclose = max(cluster_detail.closetime);
            end
            if minopen > min(cluster_detail.opentime)
                minopen = min(cluster_detail.opentime);
            end
            if minclose > min(cluster_detail.closetime)
                minclose = min(cluster_detail.closetime);
            end
        elseif strcmp('Plot_open/close', namearg)
            figure(4)
            clf;
            hold on
            idx = cluster_detail.idx(cluster_detail.mode_number, :);
            cmp = flipud(colormap(parula(max(idx))));
            for k = 1:max(idx)
                plot(cluster_detail.opentime(idx == k),...
                    cluster_detail.closetime(idx == k), 'x',...
                    'MarkerEdgeColor', cmp(k,:))
            end
            mean_open = [];
            mean_close = [];
            popen = [];
            cluster_length = [];
            for k = 1:max(idx)
                mean_open = [mean_open; exp(mean(log(cluster_detail.opentime(idx == k))))];
                mean_close = [mean_close; exp(mean(log(cluster_detail.closetime(idx == k))))];
                popen = [popen;...
                    sum(cluster_detail.opentime(idx == k))/...
                    (sum(cluster_detail.opentime(idx == k)) +...
                    sum(cluster_detail.closetime(idx == k)))];
                cluster_length = [cluster_length; length(find(idx == k))];
                plot(exp(mean(log(cluster_detail.opentime(idx == k)))),...
                    exp(mean(log(cluster_detail.closetime(idx == k)))),...
                    'o','markers',12, 'MarkerEdgeColor', cmp(k,:),...
                    'MarkerFaceColor', cmp(k,:))
            end
            summary = table(mean_open, mean_close, popen, cluster_length);
            disp(summary)
            xlim([exp(-4), exp(5)])
            ylim([exp(-4), exp(7)])
            set(gca,'xscale','log')
            set(gca,'yscale','log')
            xlabel('Open time (ms/log scale)')
            ylabel('Shut time (ms/log scale)')
            hold off
        elseif strcmp('Mode_length', namearg)
            idx = cluster_detail.idx(cluster_detail.mode_number, :);
            for k = 1:max(idx)
                result = [result, length(find(idx == k))];
            end

                
            
        end
    end
end

% Format output
if strcmp('popen_dist', namearg)
    histogram(popen_list) ;
elseif strcmp('probability', namearg)
    result = probability_array;
elseif strcmp('maxmin_open/close', namearg)
    result = [maxopen, minopen, maxclose, minclose];
elseif strcmp('total_close', namearg)
    result = total_close;
end