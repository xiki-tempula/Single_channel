function scandata(FolderPath)
if isempty(FolderPath)
    [pathstr,name,ext] = fileparts(mfilename('fullpath'));
    FolderPath = [pathstr filesep 'data'];
    if exist(FolderPath , 'dir')
        listing = dir(FolderPath);
        disp('No input is detected.')
        fprintf('Will use default pathway instead. \nSearch in %s \n', ...
        FolderPath)
    else
        disp('No data is found')
        pause
    end
else
    if exist(FolderPath , 'dir')
        listing = dir(FolderPath);
    else
        fprintf('%s is not found.', ...
        FolderPath)
    end
end

for i = 3:length(listing)
    % i start from three because the first two is '.' and '...'
    name = listing(i).name;
    if strcmp(name(end-3:end), '.csv')
        % Some filenames has INVISIBLE space in them which can cause
        % trouble so these codes sove these problems by rename the file.
        oldname = name;
        name(name=='') = '';
        Magic = 'ThisIsMagic.csv';
        movefile([FolderPath filesep oldname], Magic)
        movefile(Magic, [FolderPath filesep name])
        
        adddata([FolderPath '.mat'],[FolderPath filesep name])
    end
end
    