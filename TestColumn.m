% function TestColumn

% TestColumn;
%
%
%
% Khan 01/09/2012
 
%% Default params


%% Initialize
close all

%% Main
HemoInit
cds oGreene

FiguresHRF BootHRF*V1pt* c
mrVista
VOLUME{1} = selectDataType(VOLUME{1},'Timed');
VOLUME{1} = ComputeLaminarDistance(VOLUME{1},[], 'normalized');
VOLUME{1} = LoadLaminarIndices(VOLUME{1});
VOLUME{1} = loadROIs(VOLUME{1},'C1.mat');
VOLUME{1}.tSeries = loadtSeries(VOLUME{1});

% ROI Vol indices
viROI = coords2Indices(VOLUME{1}.ROIs(end).coords, GetDimFromAnat);

% Find corresponding layer 1 index
iLayer1 = find(viROI == GetLayer1indices);

viColumn = VOLUME{1}.laminarIndices{iLayer1};
miColumn = indices2Coords(viColumn, GetDimFromAnat);

VOLUME{1}.ROIs(end).coords = miColumn;

vDepth = getCurDataROI(VOLUME{1}); % Normalized depth
VOLUME{1}=setDisplayMode(VOLUME{1},'amp'); VOLUME{1}=refreshScreen(VOLUME{1});
VOLUME{1}=setDisplayMode(VOLUME{1},'amp'); VOLUME{1}=refreshScreen(VOLUME{1});
vAmp = getCurDataROI(VOLUME{1});

ts = getTSeriesROI(VOLUME{1}, miColumn);
mDepth = repmat(vDepth, [144 1]);

mY = nan(144, 5);

for oBin = voPlot8Bins
	vTsInBin = ts(mDepth>oBin.lower & mDepth<oBin.upper);
	% Mean over voxels in bin
	mY(:,oBin.iNum) = nanmean(reshape(vTsInBin,144,[]),2); 
	vAmpInBin = vAmp(vDepth>oBin.lower & vDepth<oBin.upper);
	% Mean over voxels in bin
	vAmpB(oBin.iNum) = nanmean(vAmpInBin(:)); 
end

vAmpB = .22*vAmpB/max(vAmpB);
figure; plot([voPlot8Bins.middle], vAmpB, 'o');

vY = NanMean(MatrixVectorDiff(mY, mY(1,:)),2);
vY = NanMean(reshape(vY, 8, 18), 2);
% figure; plot(vY);

%%

%% Note: type "doc hungarian" for variable prefix explanation.
