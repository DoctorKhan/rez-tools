function varargout = Load(xFile, varargin)

% varargout = Load(pFile, varargin);
%
% Load variables in varargin from file pFile.
%
% Khan 07/29/2011

%% Default params
% for iArg = 1:nargout
	varargout{:} = deal([]);
% end

Default xFile
xFile = TryExt(xFile);
%% Initialize
if ischar(xFile)
    o = Ls(xFile);
    if isscalar(o)
        xFile = StructName(o);
    else
        Ls(xFile); return
    end
end
pFile = FileExt(StructName(xFile), '.mat');

% if ~isFile(pFile)
% 	[filename, pathname] = uigetfile(pFile, 'Load file.');
% 	pFile = fullfile(pathname, filename);
% end


if isstruct(pFile)
	pFile = StructName(pFile);
end

if ~exist(TryExt(pFile), 'file')
	
	% 	[oView, ok] = loadROI(oView, 'V1p', 'select', '', '', 'shared', 'force');
	
	if Option('ROIs')
		% Local
		if ~Option('Gray')
			ccp{1} = SessionDir('Volume');
		end
		if ~Option('Volume')
			ccp{2} = SessionDir('Gray');
		end
		
		% Shared
		ccp{3} = AnatPath(GetSubject);
		% Explicit
		pMat = basename(FileExt(pFile, '.mat'));
		
		pFile = TryPaths(ccp, {'ROIs'}, {pMat});
	else
		if ~exist(TryExt(pFile), 'file')
			cp{1} = pFile;
			cp{2} = ['BootHRFAnalysis-*' pFile '*u[0-9]*.mat'];
			pFile = TryPaths(cp);
		end
		
		try
			pFile = strtrim(ls(pFile));
		catch
			if nargout > 0
				varargout{1} = [];
			end
			warning(['Could not read file ' squote(pFile) '. Returning empty data']);
			return
		end
	end
end

[~, ~, varargin] = Option('^(Gray|Volume|Shared|ROI)$');
varargin(cellfun(@isempty, varargin)) = [];

%% Main
if ~exist(pFile, 'file')
	Str('Could not load file.');
	varargout{:} = deal([]); return
end

if nargout == 0
	evalin('caller', Str('load', pFile));
	o = load(pFile);
	csFields = fieldnames(o);
	if isscalar(csFields)
		sField = csFields{1};
		if isstruct(o.(sField))
			evalin('caller', Str('Destruct', sField));
		end
	end
	return
end

try
	oLoad = SqueezeStruct(eval(['load(''' pFile ''');']));
catch
	varargout = {[]};
	return
end

nArgs = length(varargin);

for iArg = 1:nArgs
	try
		varargout{iArg} = eval(['oLoad.' varargin{iArg}]);
	catch
		varargout{iArg} = [];
	end
end

nExcess = nargout - nArgs;

if nExcess > 0
	varargout{nArgs+1} = oLoad;
end
if nExcess > 1
	varargout{nArgs+2} = pFile;
end

if nargout == 0
	varargout{1} = oLoad;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
