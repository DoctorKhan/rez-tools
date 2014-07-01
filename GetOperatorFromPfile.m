function sOp = GetOperatorFromPfile

% sOp = GetOperatorFromPfile;
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
sOp = Initials2Name(strtrim(oHeader.exam.op));


end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
