function strPath = whichdir(strMFileName)

% strPath = whichdir(strMFileName);
% 
% Usage:    whichdir <name of mfile>
% Purpose:  return directory to where a particular m-file is located
% Example:  which mrVista
% Result:   cd /home/khan/export/software/VISTASOFT
%
% Khan  12/1/09

%% Default params
% If no arguments supplied, we should cd to wherever this file is located
if ~exist('strMFileName', 'var'), strMFileName = 'cdm'; end

%% Main

% Find pathname of file
strPathname = which(strMFileName);

% Extract path
strPath = fileparts(strPathname);

end
