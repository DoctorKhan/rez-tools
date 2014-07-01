function sVarName = ProperVar(sVarName)

% sVarName = ProperVar(sVarName);
%
%
%
% Khan 10/17/2011

%% Default params


%% Initialize


%% Main
sVarName = regexprep(regexprep(regexprep(sVarName, '[^A-za-z0-9]', '_'), '__', '_'), '^_|_$', '');

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
