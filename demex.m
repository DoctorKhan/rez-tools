function demex(sFile)

% demex(sFile);
%
% Remove mexed file.
%
% Khan 03/15/2010

%% Default params
if notDefined('sFile'), sFile = ActiveDocument; end

%% Initialize
[p, f, ext] = fileparts(sFile);
sPathname = which(f);
[path, name, sExt] = fileparts(sPathname);


%% Main
if ~isempty(regexpi(sExt, 'mex'))
    delete(sPathname)
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
