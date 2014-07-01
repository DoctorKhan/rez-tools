function SetAnatPath(sSubject, sRegion)

%% Default params
Default sSubject = GetSubject
Default sRegion = GetRegion

%% Initialize


%% Main
assignin('base', 'vANATOMYPATH', fullfile(GetUserDir,'mri','Anatomy', [sSubject, 'HR'], sRegion, 'vAnatomy.dat'));

end % Function

