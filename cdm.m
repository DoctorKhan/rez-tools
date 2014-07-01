function sCurDir = cdm(sMFilename)

%
% Usage:    cdm <name of mfile>
% Purpose:  change directory to where a particular m-file is located
% Example:  cdm mrVista
% Result:   cd /home/khan/export/software/VISTASOFT/mrLoadRet-3.0
%
% Khan  07/29/09
%

if nargout > 0, sCurDir = pwd; end
if notDefined('sMFilename'), sMFilename = strtrim(regexprep(ActiveDocument, ' \[Read Only\]', '')); end

%% Initialize
persistent sLastDir
mlock

%% Main
% If no arguments supplied, we should cd to wherever this file is located
if strcmp(sMFilename, '-')
    if isempty(sLastDir), sLastDir = pwd; end
    sPath = sLastDir;
    sLastDir = pwd; % Set last dir
else
    % Find pathname of file
    sPathname = which(sMFilename);
    if isempty(sPathname), sPathname = sMFilename; end
    sPath = fileparts(sPathname); % Extract path

    % Set last dir
    sLastDir = pwd;
end

% Change directory
if exist(sPath, 'dir')
    cd(sPath);
end

if exist(sMFilename, 'dir')
    try
	cd(sMFilename);
    end
end

end % function
