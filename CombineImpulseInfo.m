function CombineImpulseInfo(sDir)

%
% Khan 03/10/2010

%% Default params
if notDefined('sDir'), sDir = pwd; end

%% Initialize
sCurDir = pwd;

%% Main
sPath = fileparts(which('CombineImpulseInfo'));

sDir = FindDataFiles(sDir, @CountJitterFiles);

cd(sDir);

linux(fullfile(sPath, 'combineImpulseInfo'));

cd(sCurDir);

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
