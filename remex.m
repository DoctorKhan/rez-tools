function remex(pFile)

% remex(pFile);
%
%
%
% Khan 03/15/2010

%% Default params
if notDefined('pFile'), pFile = ActiveDocument; end

%% Initialize
if notDefined(fileparts(pFile))
	if defined(fileparts(which(pFile)))
		pFile = which(pFile);
	else
		pFile = fullfile(pwd, pFile);
	end
end

[pFilePath, sBaseFilename, sFileExt] = fileparts(pFile);


if exist(FileExt(pFile, '.cpp'), 'file')
		pFileC = FileExt(pFile, '.cpp');
elseif exist(FileExt(pFile, '.c'), 'file')
		pFileC = FileExt(pFile, '.c');
end

pCurDir = pwd;

%% Main

cd(pFilePath);

SaveDocument(sPathname);

bFailed = logical(mex('-g', pFileC));

if ~bFailed
    disp('Mex succeeded.')
end

cd(pCurDir);

% if nargin > 0
%     varargout{1} = ~bFailed;
% end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
