function escript(sFuncName, sDir)

% escript(sFuncName, sDir);
%
% Creates a new m-file from template
%
% Khan 02/12/2010

if nargin == 0, return; end
%% Default
if notDefined('sDir'), sDir = 'cdm'; end

%% Initialize
if strcmp(sFuncName(end-1:end), '.m'), sFuncName = sFuncName(1:end-2); end
mFilename = [sFuncName, '.m'];

%% Main
cdm(sDir);

if exist(mFilename, 'file')
	sExisting = fparts(2, which(mFilename));
end

if exist(mFilename, 'file') && strcmp(sExisting, sFuncName)
    Alert(['File ', sExisting, ' already exists.'])
	cdm -; return
else
    sCr = sprintf('%c\n', ''); % Carriage return character

    % Make it
    sContents = ['function ', sFuncName, sCr, sCr, ...
        '%% Default params', sCr, sCr, sCr, '%% Initialize', sCr, sCr, sCr, '%% Main', sCr, sCr, sCr, ...
        'end % Function', sCr];

    dlmwrite(mFilename, sContents, '');
    SetHelp(sFuncName);
    edit(sFuncName);
end
%% clean up
cdm -;


end

%% Note: type "doc hungarian" for variable prefix explanation.
