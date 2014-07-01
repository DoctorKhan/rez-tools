function pFile = FileExtension(pFile, sExt)

% pFile = FileExtension(pFile, sExt);
%
% Changes the extension of a pathname to the desired one.
%
% Khan 10/28/2010

%% Default params
Default sExt

%% Initialize
% Strip dot from desired extension.
if isstruct(sExt), sExt = StructName(sExt); end

if ~isempty(sExt) && ~strncmp(sExt, '.', 1)
	sExt = ['.', sExt]; 
end

%% Main
[p, f, e] = fileparts(pFile);

if length(e) > 4, f = [f, e]; end

pFile = fullfile(p, [f, sExt]);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
