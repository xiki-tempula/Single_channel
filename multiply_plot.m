function multiply_plot(DataStructure, plotname)
if ~isfield(DataStructure, 'Cluster')
    % Check whether the input is a structure with multiply patches
    patch_name = fieldnames(DataStructure);
else
    % The input is only one patch with multiply clusters.
    patch_name = {'patch'};
    DataStructure = struct('patch', DataStructure);
end

for i = 1:length(patch_name)
    cluster_data = DataStructure.(patch_name{i}).Cluster;
    for j = 1:length(cluster_data)
        cluster_detail = cluster_data(j);
        plot_original_data(cluster_detail)
        if strcmp('cost_function', plotname)
            errorbar(1:10,...
                cluster_detail.NormalisedCostMu,...
                cluster_detail.NormalisedCostStd)
        elseif strcmp('open_close_distrubition', plotname)
            plotopenclose(cluster_detail)
        end
    end
end
