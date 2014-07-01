function varargout = Option2(csOpts, varargin)

% [viFound, csOpts, csRemoved, nArgs] = Option2(csOpts, varargin);
%
% Checks if option is specified.
%
% Khan 10/14/2011

%% Option2s
bFirst = CellMatch(varargin, 'first');
if bFirst, varargin(bFirst) = []; end

%% Initialize
if ~iscell(csOpts), csOpts = {csOpts}; end

if isempty(varargin)
	csInput = evalin('caller', 'varargin;');
else
	csInput = varargin;
end

if ~iscell(csOpts), csOpts = {csOpts}; end

%%
viFound = zeros(size(csOpts));

%% Defaults
xFound = [];

%% Main
for iArgIn = 1:length(csOpts)
	[xOpt, sRetType] = SplitStr(csOpts{iArgIn});
	Default sRetType = index;
	
	if isFunc(xOpt)
		viFound = find(CellFun(oFind, csInput));
		Default viFound = 0
	else
		viFound = CellMatch(csInput, oFind.name);
	end

	iFound = viFound(1); 

	if iFound
		[sName, xVal] = SplitStr(csInput{iFound});
		xVal = Str2Num(xVal);
		
		switch sRetType
			case 'index'
				varargout{iArgIn} = iFound;
			case 'name'
				varargout{iArgIn} = sName;
			case 'value'
				varargout{iArgIn} = xVal;
		end
	else
			varargout{iArgIn} = false;
	end

	viFound(iArgIn) = iFound;
end

csRemoved = csInput;
csRemoved(viFound(viFound>0)) = [];

varargout = varargout(1:nargout);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
