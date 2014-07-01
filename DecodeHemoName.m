function varargout = DecodeHemoName(sHemoName, varargin)

% o = DecodeHemoName(sHemoName);
%
%
%
% Khan 10/18/2011

%% Default params
Default sUnits & sRange & sType & sLower & sUpper
Default sDepth & nDepth & sNorm & nNorm & sThick & nThick & sCurve & nCurve

%% Initialize
% if isStructVec(sHemoName)
% 	for ii = 1:length(sHemoName);
% 		varargout{:} = DecodeHemoName(sHemoName, varargin{:});
% 		for jj = 1:nargout
% 			cxOut(jj){ii} = varargout{jj};
if isstruct(sHemoName), sHemoName = StructName(sHemoName); end
Default middle & sMiddle;
%% Main
sSubject = GetSubject(fileparts(sHemoName));
sHemoName = regexprep(sHemoName, '.*BootHRFAnalysis-', '');
sHemoName = regexprep(sHemoName, '.mat', '');

if any(sHemoName == 'u')
	sCNR = regexprep(sHemoName, '.*u', '');
else
	sCNR = '100';
end

sHemoName = regexprep(sHemoName, ['u' sCNR], '');

if any(sHemoName == ')');
	sUnits = regexprep(sHemoName, '.*\)', '');
	Default sUnits = "na"
	sRange = regexprep(regexprep(sHemoName, '.*\(', ''), '\).*', '');
	Default sRange = "na";
	sRange = p2n(sRange);
	sRange = regexprep(sRange, '([0-9])(+|-)(.)', '$1 $2 $3');
	sRange = regexprep(sRange, '  ', ' ');
	
	sLower = regexprep(sRange, '(.*[0-9]) (+|-) (.*)', '$1');
	sUpper = regexprep(sRange, '(.*[0-9]) (+|-) (.*)', '$3');
	
	sHemoName = regexprep(sHemoName, '\(.*', '');
	
	middle = nanmean([str2double(sLower), str2double(sUpper)]);
	sMiddle = num2str(middle);
end

if sHemoName(end) == 'c'
	sType = 'curvature'; sHemoName(end) = [];
elseif sHemoName(end) == 't'
	sType = 'thickness'; sHemoName(end) = [];
elseif sHemoName(end) == 'n'
	sType = 'region'; sHemoName(end) = [];
	switch sRange
		case '-1 - 0'
			sRange = 'white';
		case '0 - 1'
			sRange = 'gray';
		case '1 - 2'
			sRange = 'extrapial';
	end
else
	sType = 'depth';
end

sLam = num2str(~isempty(strfind(sHemoName, 'Laminar')));
sHemoName = regexprep(sHemoName, 'ExtraStriate', 'V23');
sHemoName = regexprep(sHemoName, '(p|dv)$', '');
sBinName = regexprep(sHemoName, 'Laminar', '');
sName = regexprep(sBinName, '.*-', '');

sNameCNR = [sName 'u' sCNR];
sPName = [sName 'p'];

if defined('sType')
	sTitle = Str(sSubject, sName, 'as a function of', sType);
	sShort = [sTitle ' (' sUnits ')'];
	if defined('sRange')
		sTitle = Str(sTitle, 'in the range of', sRange, sUnits, {' '});
	else
		sRange = 'na';
		sUnits = 'na';
	end
else
	sTitle = Str(sSubject, sName, 'in the upper', [sCNR '%'], 'of the CNR.');
end

if ~isempty(regexp(sBinName, '-', 'once'))
	sBins = regexprep(sBinName, '-.*', '');
	sDepth = regexprep(regexp(sBins, '[0-9]*D', 'match', 'once'), 'D', ' Depth bins');
	if notDefined('sDepth')
		sDepth = Str(regexp(sBins, '[0-9]*', 'match', 'once'), 'Depth bins');
	end
	sNorm  = regexprep(regexp(sBins, '[0-9]*N', 'match', 'once'), 'N', ' Norm thick bins');
	sThick = regexprep(regexp(sBins, '[0-9]*T', 'match', 'once'), 'T', ' Thick bins');
	sCurve = regexprep(regexp(sBins, '[0-9]*C', 'match', 'once'), 'C', ' Curve bins');
	
	nDepth = str2double(regexp(sDepth, '[0-9]*', 'match', 'once'));
	nNorm =  str2double(regexp(sNorm,  '[0-9]*', 'match', 'once'));
	nThick = str2double(regexp(sThick, '[0-9]*', 'match', 'once'));
	nCurve = str2double(regexp(sCurve, '[0-9]*', 'match', 'once'));	
end

%% Output
oHemoName = Struct(sName, sPName, sCNR, sNameCNR, sType, sRange, sLower, ...
	sUpper, sUnits, sLam, sTitle, sDepth, nDepth, sNorm, nNorm, sThick, ...
	nThick, sCurve, nCurve, middle, sShort, sMiddle, sSubject);

nArgs = length(varargin);

for iArg = 1:nArgs
	try
		varargout{iArg} = getfield(oHemoName, varargin{iArg});
	catch
		varargout{iArg} = [];
	end
end

nExcess = nargout - nArgs;

if nExcess > 0
	varargout{nArgs+1} = oHemoName;
end

if nargout == 0
	oHemoName
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
