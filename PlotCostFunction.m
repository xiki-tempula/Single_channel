function multiply_plot(DataStructure, plotname)
patch_name = fieldnames(DataStructure);

if isfield(DataStructure, 'Cluster')
    
if strcmp('cost_function', plotname)
    figure
    hold on
    for a = 1:length(patch_name)
        cluster_number = fieldnames(DataStructure.(patch_name{a}));
        for b = 1:length(cluster_number)
            if length(cluster_number{b}) > 7
                cluster_name = cluster_number{b};
                if strcmp(cluster_name(1:7), 'Cluster')
                    CostMu = DataStructure.(patch_name{a}).(cluster_number{b}).CostMu;
                   CostStd = DataStructure.(patch_name{a}).(cluster_number{b}).CostStd;
                    NormalisedCostMu = CostMu ./ max(CostMu);
                    NormalisedCostStd = CostStd ./ max(CostMu);
                    errorbar(1:10, NormalisedCostMu, NormalisedCostStd)
                end
            end
        end
    end
    hold off
elseif strcmp('open_close_distrubition', plotname)