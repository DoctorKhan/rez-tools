function root = GetRootPath

% root = GetRootPath;
% 
% Gets the location of the export directory.
% 
% Khan 11/17/2009

if str2double(linux('uname -a | grep -ic sandstone'))
    root=[];
else
    root = linux('echo -n $HOME');
end

end
