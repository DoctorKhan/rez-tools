function sPathname = ExportPath(varargin)

% sPathname = ExportPath(varargin);
% 
% Gets the location of the export directory (or whatever directory contains
% "mri" and "software" subdirectories). If you pass it a directory, or a
% comma seprated list of subfolders, it will append the path to the export
% directory location.
% 
% Khan 11/19/2009
%
% Greene 02/12, modified to work with MATLAB sessions run on Windows


%% Default
if nargin == 0
    sDir = []; 
else
    varargin = CellFun(@StructName, varargin);
end


if nargin == 1
    sDir = varargin{1};
else
    sDir = fullfile(varargin{:});
end

%% Strip /home/user/export
if ischar(sDir), sDir = regexprep(sDir, fullfile(GetUserDir, 'export/data'), ''); end
if ischar(sDir), sDir = regexprep(sDir, fullfile(GetUserDir, 'export'), ''); end
if ischar(sDir), sDir = regexprep(sDir, GetUserDir, ''); end

%% Get exportpath
% This is the directory which should contain "mri" and "software"
% subdirectories
if isunix
    csExport = {'/Volumes', '/export/data', '/export', fullfile(GetUserDir, 'export'), '/media/export'};
else
    % This needs to be fixed to search common locations on a pc
    csExport = {'X:', 'Y:', 'Z:', 'E:', 'F:', 'G:', ...
        fullfile(GetUserDir, 'export')};
end

% Find first export directory that exists
nDirs = length(csExport);
for iDir = 1:nDirs
    sExport = csExport{iDir};
    if exist(sExport, 'dir') && exist(fullfile(sExport, 'mri'), 'dir')
        break; 
    elseif exist(sExport, 'dir') && exist(fullfile(sExport, 'Raw'), 'dir') 
        % for windows machines
        sDir = regexprep(sDir, 'mri', '');
        break;
    elseif iDir == nDirs
        error(['Could not find a valid directory contain "mri" and ' ...
            '"software subdirectories. Please modify ' mfilename ...
            ' to accommodate your computer']);
    end
end

%% Main
sPathname = fullfile(sExport, sDir);

csFind = {'.*export', '.*Volumes', '/data/data/', 'data/'};
csRep  = {sExport,    sExport,     '/data',       ''     };

for ii = 1:length(csFind)
	sPathTry = regexprep(sPathname, csFind{ii}, csRep{ii});
	if exist(sPathTry, 'file')
		sPathname = sPathTry;
		break
	end
end

%     warning([sPathname ' does not exist']);

end %function
