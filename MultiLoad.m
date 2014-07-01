function varargout = MultiLoad(voFiles, varargin)

% varargout = Load(pFile, varargin);
%
% Load variables in varargin from multiple files pFile.
%
% Khan 07/29/2011

%% Default params

%% Initialize
nFiles = length(voFiles);
varargin(cellfun(@isempty, varargin)) = [];
nArgs = length(varargin);

%% Main
for iFile = 1:nFiles
	if nArgs == 0
		varargout{1}{iFile} = Load(voFiles(iFile));
	else
		for iArg = 1:nArgs
			varargout{iArg}{iFile} = Load(voFiles(iFile), varargin{iArg});
		end
	end
end

end % function