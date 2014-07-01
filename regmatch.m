function viFound = regmatch(sString, sExpr, varargin)

% bMatch = regmatch(sString, sExpr, varargin);
%
% regular expression match of string.
%
% Khan 03/24/2012
 
%% Default params

%% Initialize
if ~iscell(sString), sString = {sString}; end;

%% Main
cbMatch = regexp(sString, sExpr, 'once');
vbMatch = ~CellFun(@isempty, cbMatch);
viFound = find(vbMatch, 1, 'first');
Default viFound = 0;

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
