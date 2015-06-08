function multiply_analysis(DataStructure, namearg, plotoriginal)

if ~isfield(DataStructure, 'Cluster')
    % Check whether the input is a structure with multiply patches
    patch_name = fieldnames(DataStructure);
else
    % The input is only one patch with multiply clusters.
    patch_name = {'patch'};
    DataStructure = struct('patch', DataStructure);
end

if strcmp('popen_dist', namearg)
    popen_list = [];
elseif strcmp('cost_function', namearg)
    figure(3)
end

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
            figure(3)
            hold on
            plot(1:length(cluster_detail.NormalisedCost),...
                cluster_detail.NormalisedCost)
            hold off
        elseif strcmp('open_close_distrubition', namearg)
            plotopenclose(cluster_detail)
        elseif strcmp('popen_dist', namearg)
            popen_list = [popen_list cluster_detail.totalPopen];
        end
    end
end

if strcmp('popen_dist', namearg)
    histogram(popen_list) ;
end
