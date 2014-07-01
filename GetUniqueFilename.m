function sFilename = GetUniqueFilename(sBasename, sExt, sDir)

%% Default params
if ~exist('sExt', 'var'), sExt = '';
else sExt = ['.', sExt]; end

if ~exist('sDir', 'var'), sDir = pwd; end

%% Main
iFileNum = 0;
sTestName = [sBasename, '-', date, '-', num2str(iFileNum, '%02d'), sExt];
sTestName = fullfile(sDir,sTestName);
while exist(sTestName, 'file')
    iFileNum = iFileNum + 1;
    sTestName = [sBasename, '-', date, '-', num2str(iFileNum, '%02d'), sExt];
    sTestName = fullfile(sDir,sTestName);
end
sFilename = sTestName;

end