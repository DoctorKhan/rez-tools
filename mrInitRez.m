function mrInitRez(sType, vIs3d)

%
% mrInitRez(sType, vIs3d);
%
% Provides automated actions for mrInitRet.
%
% Khan - early 2009
%

%% Default params
if notDefined('vIs3d'), vIs3d = []; end
vCheck = [];

%% setup
if ~exist(fullfile(pwd,'Raw'), 'dir')
    cd(fullfile(ExportPath, 'mri', 'Raw', MostRecent('session')));
end

%% Main
if defined('sType')
    switch sType
        case 'clean'         
            %delete existing files if they exist
            if exist([pwd, '/Inplane'], 'dir'), rmdir('Inplane', 's'); end;
            if exist('mrSESSION.mat', 'file'), delete('mrSESSION.mat'); end;
            if exist('mrSESSION_backup.mat', 'file'), delete('mrSESSION_backup.mat'); end;
            if exist('Between_Scan_Motion.txt', 'file'), delete('Between_Scan_Motion.txt'); end;
        case 'hrf'
            vCheck = [1 0 0 1 1 1];            
            mrInitRet([], vIs3d, vCheck, 'all')
            mrVista
    end
else
%call main routine
mrInitRet([], vIs3d, vCheck)
mrVista
end
end

