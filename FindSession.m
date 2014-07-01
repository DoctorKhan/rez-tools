function varargout = FindSession(sSession, varargin)

% varargout = FindSession(sSession, varargin);
%
% Find session information.
% Usage: "FindSession 0924" or
%        "info = FindSession('0924')" to find sessions on September 24th.
%        "FindSession 0924 update" to update the session database first.
%
% Note: Sessions without a Readme.txt file are not catalogued.
%
% Can use regular expressions to match.
% "FindSession \<10"              October sessions only
% "FindSession \d\d24"            The 24th of any month
% "FindSession \d\d\d\d09"        Any session in 2009
% "FindSession \d\d\d\d\d\drk"    Any session with subject khan
% "FindSession venography"        Find venography sessions
% Khan 02/22/2010
% Khan 03/06/2010 - Added "full" option to display full description.
% Khan 03/12/2010 - Made full option default (for now).
% Greene 11/30/2011 - Added 

%% Initialize
nDaysBetweenUpdates = 3;

vColWidths = []; bFull = true;
sDatabase = ExportPath('mri', 'Sessions', 'SessionDatabase.csv');

if ~exist(sDatabase, 'file')
	bUpdate = true;
else
	iCurrentDate = datenum(date);
	oDatabase = dir(sDatabase);
	iFileDate = floor(datenum(oDatabase.date));
	
	bUpdate = (iCurrentDate - iFileDate > nDaysBetweenUpdates);
end

%% Argument handling
for iArg = 1:nargin-1
	arg = varargin{iArg};
	if ischar(arg)
		sArg = arg;
		if isequal(sArg, 'update') || isequal(sArg, 'build')
			bUpdate = true;
		elseif isequal(sArg, 'full') || isequal(sArg, 'complete')
			bFull = true;
		end
	elseif isnumeric(arg)
		vColWidths = arg;
	end
end

%% Defaults
if notDefined('sSession')
	help FindSession
	varargout{:} = [];
  return;
end

if notDefined('vColWidths'), vColWidths = [inf, inf, inf, 20, inf]; end
if bFull, vColWidths(end-1) = inf; end

%% Main
if bUpdate, BuildSessionDatabase, disp(' '); end

csFile = ReadTextFile(sDatabase);
% csInfo{1} = strtrim(csFile{1});
ccInfo{1} = regexpi(csFile{1}, '\t', 'split');

for iFile = 2:length(csFile)
	if ~isempty(regexpi(csFile{iFile}, sSession))
		ccInfo{end+1} = regexpi(strtrim(csFile{iFile}), '\t', 'split');
	end
end

if length(ccInfo) < 2
	ccInfo = [];
end

if nargout == 0
	if isempty(ccInfo)
		disp('Session not found.')
	else
		DatabaseDisplay(ccInfo, vColWidths)
	end
	
	if ~bUpdate
		disp(['BuildSessionDatabase last run ', num2str(iCurrentDate - iFileDate), ' days ago on ', datestr(iFileDate, 'mmm dd, yyyy'), '.'])
	end
else
	varargout{1} = ccInfo;
end

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
