function sExt = Ext(pFile)

% sExt = Ext(pFile);
%
%
%
% Khan 04/05/2011

%% Default params
%% Initialize

%% Main
[~, ~, sExt] = fileparts(pFile);
if length(sExt) > 5, sExt = ''; end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
