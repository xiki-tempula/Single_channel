function data = readcsv(filename)

fid = fopen(filename);
out = textscan(fid,'%s','delimiter',',');
fclose(fid);

[pathstr,name,ext] = fileparts(filename);
data = struct('filepath', pathstr,...
    'filename',name,...
    'extension',ext);

tempcell = out{1};
emptyCells = cellfun('isempty', tempcell);
tempcell(emptyCells) = [];

celllength = length(tempcell);
if mod(celllength,11) == 0
    out = reshape(tempcell,[11, celllength/11]);
else
    disp('Cell length error')
    pause
end

out = out([3 5 6 7 9], :);
out = cellfun(@(x)str2double(x), out);

ChannelState = out(1,:);
StartTime = out(2,:);
EndTime = out(3,:);
Amplitude = out(4,:);
Duration = out(5,:);

% Separating the clusters
start = 1;
stop = double.empty(0,0);
for i = 1:length(EndTime)-1
    % Separate the different cluster if the end time is 100ms later
    % than the previous start stime.
    if (StartTime(i+1) - EndTime(i)) > 100
        start = [start i+1];
        stop = [stop i];
    end
end
stop = [stop length(EndTime)];
start = sort(start);
stop = sort(stop);

% Discard the cluster if the cluster length is less than 100ms
if length(start) > 2
    for i = 1:length(stop)
        if sum(Duration(start(i):stop(i))) < 100
            start(i) = [];
            stop(i) = [];
        end
    end
end

data.Cluster = struct(...
        'starttime', {},...
        'endtime', {},...
        'totalPopen', {},...
        'mean_amplitude', {},...
        'clusterduration', {},...
        'opentime', {},...
        'closetime', {},...
        'eventtime', {},...
        'amplitude', {});

fprintf('%u of clusters has been found in this patch. \n', length(start))
for i = 1:length(start)
    fprintf('Start reading data from cluster %u. \n', i)
    

    starttime = StartTime(start(i));
    endtime = EndTime(stop(i));
    
    state = ChannelState(start(i): stop(i));
    DwellTime = Duration(start(i): stop(i));
    amplitude = Amplitude(start(i): stop(i));
    endevent = EndTime(start(i): stop(i));
    
    cluster_duration = sum(DwellTime);
    
    opentime = DwellTime(state == 1);
    closetime = DwellTime(state == 0);
    eventtime = endevent(state == 1);
    
    Clusterlength = min([length(opentime), length(closetime), length(eventtime)]);
    
    opentime = opentime(1:Clusterlength);
    closetime = closetime(1:Clusterlength);
    eventtime = eventtime(1:Clusterlength);
    amplitude = amplitude(1:Clusterlength*2);
    mean_amplitude = mean(amplitude(1:2:end) - amplitude(2:2:end));
    
    totalPopen = sum(opentime)/(sum(closetime) + sum(opentime));

    Cluster = struct(...
        'starttime', starttime,...
        'endtime', endtime,...
        'totalPopen', totalPopen,...
        'mean_amplitude', mean_amplitude,...
        'clusterduration', cluster_duration,...
        'opentime', opentime,...
        'closetime', closetime,...
        'eventtime', eventtime,...
        'amplitude', amplitude);
    
    %data = setfield(data,['Cluster', num2str(i)],Cluster);
    data.Cluster = [data.Cluster; Cluster];
end