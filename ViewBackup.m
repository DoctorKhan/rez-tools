function ViewBackup(sFile, sDateDesired)

% ViewBackup(sFile, sDateDesired);
%
% View a file from an archived backup.
% Examples: 
% "ViewBackup laplace.mat" view backup from yesterday
% "ViewBackup laplace.mat 12-03-09" view backup from Dec. 3rd. 
%
% Any kind of date string will work. ie. 12/3/09 or 3-Dec-2009, etc.
%
% Khan 04/06/2010


%% Default params
Default sFile = ActiveDocument;
    
if notDefined('sDateDesired')
    sDateDesired = Yesterday;
end


%% Argument handling
sCurrentPathname = GetFullPathname(sFile, 0, 'file');

%% Main
sMonth = datestr(sDateDesired, 'mmmyyyy');
sDate = datestr(sDateDesired, 'dd');

csDatePath{1} = fullfile(sMonth, sDate);
csDatePath{2} = fullfile('backup', csDatePath{1});
csDatePath{3} = fullfile('backups', csDatePath{1});

csTemp = regexp(sCurrentPathname, 'export/', 'split');
csRelPath{1} = csTemp{end};
csRelPath{2} = fullfile('data', csRelPath{1});

sBackupPathname = TryPaths({ExportPath}, csDatePath, csRelPath);
disp(['Displaying... ', sBackupPathname, ' from'])

edit(sBackupPathname);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
