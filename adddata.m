function adddata(databasepath,newfilename)
global iters_count convergance
K = 10;
max_iters = 400;
repeat = 100;


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


allproperties = fieldnames(ClusterData.(['H', name]));
for i = 1:length(allproperties)
    ClusterNumber = allproperties{i};
    if (length(ClusterNumber) >= 7)
        if strcmp(ClusterNumber(1:7), 'Cluster')
            
            %if ~isfield(ClusterData.(['H', name]).(ClusterNumber), 'CostStd')
            %    fprintf('%s has not been analyzed using Nearest K-means. \n', ClusterNumber)
            %    fprintf('Start calculating the cost function of %s. \n', ClusterNumber)

                %ClusterData.(['H', name]).(ClusterNumber) = Kmeans_Clustering(ClusterData.(['H', name]).(ClusterNumber), K, max_iters, repeat);
            %end
        end
    end
end

save(databasepath, 'ClusterData')