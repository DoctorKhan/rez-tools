function sBackupPathname = BackupPath(sCurrDir, sDateDesired)

% sBackupPathname = BackupPathname(sCurrDir, sDateDesired);
%
% Returns the pathname to a backup file.
%
% Khan 07/06/2010

%% Default params
if notDefined('sCurrDir'), sCurrDir = pwd; end
if notDefined('sDateDesired'), sDateDesired = Yesterday; end

%% Initialize


%% Main
sMonth = datestr(sDateDesired, 'mmmyyyy');
sDate = datestr(sDateDesired, 'dd');

csDatePath{1} = fullfile(sMonth, sDate);
csDatePath{2} = fullfile('backup', csDatePath{1});
csDatePath{3} = fullfile('backups', csDatePath{1});

csTemp = regexp(sCurrDir, 'export/', 'split');
csRelPath{1} = csTemp{end};
csRelPath{2} = fullfile('data', csRelPath{1});

csExportPaths = {ExportPath, '/export'};
sBackupPathname = TryPaths(csExportPaths, csDatePath, csRelPath);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
