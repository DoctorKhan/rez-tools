function RestoreFromBackup(sDateDesired, sDir)

% RestoreFromBackup(sDateDesired, sDir);
%
% Buggy.
% Restore a file from an archived backup.
% Examples: 
% "RestoreFromBackup" shows backup from yesterday
% "RestoreFromBackup 12-03-09 /users/all" shows backup from Dec.
% 3rd in directory /users/all
%
% Any kind of date string will work. ie. 12/3/09 or 3-Dec-2009, etc.
%
% Khan 03/12/2010 - Created.
% Khan 11/08/2010 - Modfied from single file restore to double file browser
% view.

%% Default params
if notDefined('sDateDesired'), sDateDesired = Today; end
% 
% if notDefined('sDir')
%     sDir = pwd;
% else
%     sCurDir = pwd;
%     cd(sDir); RestoreFromBackup(sDateDesired);
%     cd(sCurDir); return;
% end



%% Argument handling

%% Main
nautilus(linux('BackDir'));
nautilus(linux('NormDir'));
% sBackupPath = BackupPathname(sDir, sDateDesired);


% nautilus(sDir); nautilus(sBackupPath);
% disp(['Restoring...    ', sDir, ' from'])
% disp(sBackupPath)

% try
%     copyfile(sBackupPath, sCurrentPathname, 'f');
% catch
% end
% disp(' ')
% ls('-l', sCurrentPathname)

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
