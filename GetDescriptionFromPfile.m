function sDes = GetDescriptionFromPfile

% sDes = GetDescriptionFromPfile;
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
sDes = strtrim(oHeader.exam.ex_desc);


end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
