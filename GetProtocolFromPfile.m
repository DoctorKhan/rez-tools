function sProtocol = GetProtocolFromPfile

% sProtocol = GetProtocolFromPfile;
%
%
%
% Khan 05/04/2010

%% Default params


%% Initialize
sPfileDir = FindDataFiles;

%% Main
voDir = dir(fullfile(sPfileDir, 'P*.7'));
sPfileName = voDir(end).name;
oHeader = read_gehdr(fullfile(sPfileDir, sPfileName));

%% Output
sProtocol = strtrim(regexprep(oHeader.series.prtcl, '/', ''));

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
