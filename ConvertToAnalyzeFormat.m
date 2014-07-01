function ConvertToAnalyzeFormat(pfDir, iScan, iSlice)

%% default params
if ~exist(pfDir, 'var'), pfDir = '.'; end
if ~exist('iSlice', 'var'), iSlice = 1; end
if ~exist('iScan', 'var'), iScan = 1; end

%% Initialization
pfDir = fileparts(FindDataFiles(pfDir));
Volume = GetTimeSeries(pfDir, iScan, iSlice);

sp = GetScanParams(pfDir);
res = sp(iSlice).voxelSize;

sOutputFilename = [ fullfile(pfDir, sp(iScan).PfileName), 's', num2str(iSlice), '.img'];

SaveAsAnalyzeFormat(Volume, res, sOutputFilename);

end