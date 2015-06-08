function ClusterData = update_summary(ClusterData)


patch_name = fieldnames(ClusterData);
for i = 2:length(patch_name)
    % start from 2 because there is the first field is summary
    if ~isempty(ClusterData.summary)
        if any(strcmp(patch_name{i}, ...
                table2cell(ClusterData.summary(:,1))))
            patch_exist = true;
        else
            patch_exist = false;
        end
    else
        patch_exist = false;
    end

    if ~patch_exist
        cluster_data = ClusterData.(patch_name{i}).Cluster;
        for j = 1:length(cluster_data)
            patch = patch_name{i};
            patch = {patch};
            cluster_name = j;
            starttime = cluster_data(j).starttime;
            endtime = cluster_data(j).endtime;
            totalPopen = cluster_data(j).totalPopen;
            mean_amplitude = cluster_data(j).mean_amplitude;
            clusterduration = cluster_data(j). clusterduration;
            new_cluster = table(patch, cluster_name, starttime, endtime,...
                totalPopen, mean_amplitude, clusterduration);

            ClusterData.summary = [ClusterData.summary; new_cluster];
        end
    end
end
