function bLog = str2log(sString)

% str2log;
%
%
%
% Khan 08/31/2010

%% Default params


%% Initialize


%% Main
bLog = strncmpi(sString, 'true', 4) || strncmpi(sString, 'yes', 3) || strncmpi(sString, 'on', 2) || strncmpi(sString, '1', 1);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
