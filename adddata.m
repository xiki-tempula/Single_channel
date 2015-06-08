function adddata(databasepath,newfilename)

K = 10;
max_iters = 400;
repeat = 10;


[pathstr,database_name,ext] = fileparts(databasepath);
if exist(databasepath, 'file') == 2
    fprintf('Database %s is found. \n', database_name)
    % load() itself will generate a structure and the first element of that
    % structure is the data that we need. So the following three line of
    % code deals with this
    LoadedStruct = load(databasepath);
    FieldName = fieldnames(LoadedStruct);
    ClusterData = LoadedStruct.(FieldName{1});
    
    fprintf('Database %s Loaded. \n', database_name)
else
    fprintf('Database %s is not found. \n', database_name)
    ClusterData = struct;
    ClusterData.summary = [];

    
    fprintf('Database %s is created. \n', database_name)
end

[pathstr,name,ext] = fileparts(newfilename);

if isfield(ClusterData,['H', name])
    fprintf('%s already exists in the database. \n', name)
    fprintf('%s will not be added to the database. \n', name)
else
    fprintf('%s does not exist in the database. \n', name)
    data = readcsv(newfilename);
    ClusterData = setfield(ClusterData,['H', name],data);
    fprintf('%s has been added to the database. \n', name)
end


for i = 1:length(ClusterData.(['H', name]).Cluster)
    if isempty(ClusterData.(['H', name]).Cluster(i).Cost)
        %plot_original_data(ClusterData.(['H', name]).Cluster(i))
        
        fprintf('Cluster %u has not been analyzed using Nearest K-means. \n', i)
        fprintf('Start calculating the cost function of Cluster %u. \n', i)
        fprintf('Choosing the way of looking at K-means iteration \n')
        prompt = 'repeat for each repeat and iteration for each iteration';
        
        show_process = 'off';
        %show_process = lower(input(prompt,'s'));
        
        if isempty(show_process)
            show_process = 'off';
        elseif strcmp(show_process, 'r')
            show_process = 'repeat';
        elseif strcmp(show_process, 'i')
            show_process = 'iteration';
        elseif (strcmp(show_process, 'repeat') || strcmp(show_process, 'iteration'))
        else
            fprintf('Input (%s) is not recognised. By default, hide the process \n', show_process)
            show_process = 'off';
        end
        ClusterData.(['H', name]).Cluster(i) = brute_force_sort(...
            ClusterData.(['H', name]).Cluster(i), K);
        %{
        ClusterData.(['H', name]).Cluster(i) = Kmeans_Clustering_hw(...
            ClusterData.(['H', name]).Cluster(i), K, max_iters, repeat, ...
            show_process);
        %}
         
    end
end

ClusterData = update_summary(ClusterData);
save(databasepath, 'ClusterData')