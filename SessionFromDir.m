function sOut = SessionFromDir(pPath)

% sOut = SessionFromDir;
%
%
%
% Khan 07/18/2011

%% Default params
Default pPath = pwd;

%% Initialize

%% Main
sOut = regexp(pPath, '[0-9]{6}[a-z]{2}', 'match');

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
