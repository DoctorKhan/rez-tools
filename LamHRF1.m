function oResults = LamHRF(view, baseROI, cnr, voBins, tsSliceBlock, normDepthMap, nBootstraps)

% oResults = LamHRF(view, baseROI, cnr, voBins, tsSliceBlock, normDepthMap, nBootstraps);
%
% Laminar HRF Analysis simpler
%
% Khan 07/26/2011

%% Default params

viDim = GetDimFromAnat;

%% Initialize
interpSampleFactor = 0.01; % Inverse factor to be multiplied by the period to generate the number of interpolated points
ROIName = [baseROI.name, 'u', num2str(cnr)];

period = HRFInfo('trialPeriod');

%% Prepare ROI
% Load ROI
disp(['Loaded ROI ', ROIName, '...']);
roi = getfield(load(SessionDir('Gray', 'ROIs', ROIName)), 'ROI');

% Mark it through depth
mROICoords = MarkLaminarROI(view, roi);
roiMask = false(1, size(view.coords, 2));
roiInds = coords2Indices(mROICoords, viDim);
[~, inds] = intersect(coords2Indices(view.coords, viDim), roiInds);
roiMask(inds) = true;

% Good voxels mask
sumTS = squeeze(sum(sum(tsSliceBlock,1),2));
fints = isfinite(sumTS);
goodDepths = normDepthMap >= -1 & normDepthMap <=2;
nonzeroTS = sumTS ~= 0;

finalMask = roiMask(:) & fints(:) & goodDepths(:) & nonzeroTS(:);
if total(finalMask) == 0, error('Empty mask'); end

tsROI = tsSliceBlock(:,:,finalMask);
if any(~isfinite(tsROI(:))), error(1, 'Nonfinite value in ROI.'); end

roiDepth = normDepthMap(finalMask);
roi.coords = indices2Coords(VolumeIndices(view.sessionCode, finalMask), viDim); roi.name = [roi.name, ' - marked'];

%% Make voBins
% Preallocate
nBins = length(voBins); nFramesPerTrial= size(tsROI, 1); nTrials = size(tsROI, 2);
tsBinned = zeros(nFramesPerTrial, nTrials,  nBins);

% Remove empty voBins

goodBins = logical(size(voBins));
for oBin = voBins;
	binDepths = (roiDepth >= oBin.lower & roiDepth < oBin.upper);
	tsBinned(:,:,oBin.iBin) = mean(tsROI(:,:,binDepths),3);
	
	goodBins(oBin.iNum) = any(binDepths);
end
	
% voBins(~goodBins) = [];
[voBins,  nBins] = NumStruct(voBins(goodBins));
roi.voBins = voBins;

%% Make oBin ROIs
if defined('bDebugMode') && bDebugMode
	for oBin = voBins
		% Depth range string
		sRange = [num2str(oBin.lower), '-', num2str(oBin.upper)];
		
		binCoords = indices2Coords(VolumeIndices(view.sessionCode, binDepths), viDim);
		view = newROI(view, [ROIName, 'Depth', sRange], 'select', '', binCoords);
		
		% Add to voBins structure
		voBins(oBin.iBin).roi = view.ROIs(end); % Add ROI to structure
	end
	
	saveAllROIs(view, 'local', 'force');
end

%% Bootstrap params
disp(['Attempting ', num2str(nBootstraps), ' bootstraps.']);
hrfs = [];

for oBin = voBins    % Loop over ROIs in vROIList
	iBin = oBin.iBin;
	iDepth = oBin.iNum;
	
	disp(['Bootstrapping bin ', num2str(iBin), '...'])
	
	ts = squeeze(tsBinned(:,:,iBin));
	
	% zero point
	oHRF = HRFAnalysis(ts, period);
	
	if ~exist('oHRFs', 'var')
		oHRFs = repmat(oHRF, [1, nBins]);
	else
		oHRFs(iBin) = oHRF;
	end
	zeroPoint = oHRF.zeroPoint;
	
	% Preallocate
	if notDefined('moBootParams')
		moBootParams = repmat(oHRF.oParams, nBootstraps, nBins);
	end
	mHRFs = nan([nBootstraps, length(oHRF.vY)]);
	nTrials = size(ts, 2);
	
	% Bootstrap iteration loop
	for iStrap = 1 : nBootstraps
		% 1. Resample data - sample with replacements the trial numbers
		vResampledTrials = randsample(nTrials, nTrials, 'true');
		
		% Mean across resampled trials, TimeSamples x nTrials
		mResampledData = ts(:, vResampledTrials); 
		[ ~, ~, ~, vY, oParamAnalysis] = HRFAnalysis(mResampledData, period, zeroPoint, interpSampleFactor);
		
		%Get HRFs
		mHRFs(iStrap, :) = vY;
		%Get HRF parameters
		moBootParams(iStrap, iDepth) = oParamAnalysis;
		
		TimedWaitbar(iStrap/nBootstraps, 'Bootstrapping over trials');
	end % Bootstrap loop
	hrfs = [hrfs, CalcStats(mHRFs)];
	hrf1 = CalcStats(mHRFs);
	if ~exist('hrfs', 'var')
		hrfs = repmat(hrf1, [1, nBins]);
	else
		hrfs(iDepth) = hrf1;
	end
end % oBin loop

omBootParams = HRFStructArray2Struct(moBootParams);
params = ForEachFieldOf(omBootParams, @CalcStats);

%% Output
oResults = Struct(params, hrfs, oHRFs, roi);
Save(['BootHRFAnalysis-', ROIName], oResults);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
