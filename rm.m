function rm(varargin)

% rm(varargin);
%
% delete a file.
% Example: rm asdf
% Result: deletes "asdf.m"
% "rm asdf.m" will also work
%
% Khan 02/15/2010


%% Argument handling
if nargin == 0, return; end
%% Main

for ii = 1:nargin
    sFile = varargin{ii};
    if isempty(sFile)
        continue
    elseif ischar(sFile)
        voFiles = dir(sFile);
    else
        voFiles = sFile;
    end
    
    for oFile = voFiles
        if isFile(oFile.name)
            delete(oFile.name);
        end
    end
end

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
