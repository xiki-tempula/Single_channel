function result = multiply_analysis(DataStructure, namearg, plotoriginal)

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

if strcmp('popen_dist', namearg)
    popen_list = [];
elseif strcmp('probability', namearg)
    probability_array = [];
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
        end
    end
end

if strcmp('popen_dist', namearg)
    histogram(popen_list) ;
elseif strcmp('probability', namearg)
    result = probability_array;
end
