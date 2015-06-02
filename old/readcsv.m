function data = readcsv(filename)

fid = fopen(filename);
out = textscan(fid,'%s','delimiter',',');
fclose(fid);

[pathstr,name,ext] = fileparts(filename);
data = struct('filepath', pathstr,...
    'filename',name,...
    'extension',ext,...
    'starttime',[],...
    'endtime',[],...
    'opentime',[],...
    'closetime',[],...
    'eventtime',[],...
    'totalPopen',[],...
    'ModeNumber',[],...
    'ModeDetail',[]);
    

tempcell = out{1};
emptyCells = cellfun('isempty', tempcell);
tempcell(emptyCells) = [];

celllength = length(tempcell);
out = reshape(tempcell,[11, celllength/11]);

out = out([5 6 7 9], :);
out = cellfun(@(x)str2double(x), out);
data.starttime = out(1,1);
data.endtime = out(2,end);
data.opentime = out(4,1:2:end-1);
data.closetime = out(4,2:2:end-1);
data.eventtime = out(1,2:2:end-1) - data.starttime;
data.totalPopen = sum(data.opentime)/(sum(data.opentime) + sum(data.closetime));
end
