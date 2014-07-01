function BuildSessionDatabase

% BuildSessionDatabase;
%
% Builds a session database to be searched with FindSession
%
% Khan 02/22/2010

%% Default params


%% Initialize


%% Main
if isunix || ismac
   system(ExportPath('mri', 'Sessions', 'BuildSessionDatabase'));
else
    warning(1, 'Can''t build session database in windows.');
end

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
