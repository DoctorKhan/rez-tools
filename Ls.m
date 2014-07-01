function varargout = Ls(xIn, varargin)
	
% varargout = Ls(varargin);
%
% ls without the errors.
%
% Khan 09/19/2011
% Khan 10/19/2011 - added struct array output

%% Initialize
[bVerbose, ~, varargin] = Option('-v|verbose');
[bName,    ~, varargin, xFound, nArgs] = Option('name');
Default xIn

% Pass through if no chars
if ~ischar(xIn)
	varargout{1} = xIn;
	return
else
	if exist(xIn, 'file')
		xIn = dquote(xIn);
	end
end

for iArg = 1:nArgs
	sIn = varargin{iArg};
	if exist(sIn, 'file')
		varargin{iArg} = dquote(sIn);
	end
end

sCommand = 'ls -1B';
sInput = Str(sCommand, xIn, varargin{:}); % Concatenate input args with spaces

%% Main
% Call command
[sList, bFailed] = linux(sInput);

csFiles = str2cell(sList);
voFiles = Str2Struct(sList);

if bName
	cOut = {csFiles, voFiles};
else
	cOut = {voFiles, csFiles};
end

%% Output
% Show output, if success
if ~bFailed
	if bVerbose || nargout == 0
		linux(sInput);
	end
	varargout = cOut(1:nargout);
else
	varargout = cell(1, nargout);
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
