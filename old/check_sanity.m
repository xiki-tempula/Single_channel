function [FileName,PathName,FilterIndex] = check_sanity(FileName,PathName,FilterIndex)
%Ckecking the sanity of the user

while FilterIndex ~= 1
    [FileName,PathName,FilterIndex] = uigetfile('*.csv','Select the csv file to begin analysis');
    if FilterIndex == 0
        errordlg('No file is selected.','File Error');
    else
        errordlg('Selected file is not a csv file.','File Error');
    end
end
end

