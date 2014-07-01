function oResults = LamHRF2(view, baseROI, cnr, voBins, tsSliceBlock, normDepthMap, nBootstraps)

% LamHRF;
%
% Laminar HRF Analysis simpler
%
% Khan 07/26/2011

%% Default oParams

viDim = GetDimFromAnat;

%% Initialize
interpSampleFactor = 0.01; % Inverse factor to be multiplied by the period to generate the number of interpolated points
ROIName = [baseROI.name, 'u', num2str(cnr)];

period = HRFInfo('trialPeriod');

%% Prepare ROI
% Load ROI
disp(['Loaded ROI ', ROIName, '...']);
oROI = getfield(load(SessionDir('Gray', 'ROIs', ROIName)), 'ROI');

% Mark it through depth
mROICoords = MarkLaminarROI(view, oROI);
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
oROI.coords = indices2Coords(VolumeIndices(view.sessionCode, finalMask), viDim); oROI.name = [oROI.name, ' - marked'];

%% Make voBins
% Preallocate
nBins = length(voBins); nFramesPerTrial= size(tsROI, 1); nTrials = size(tsROI, 2);
tsBinned = zeros(nFramesPerTrial, nTrials,  nBins);

% Remove empty voBins

vbGoodBins = logical(size(voBins));
for oBin = voBins;
	binDepths = (roiDepth >= oBin.lower & roiDepth < oBin.upper);
	tsBinned(:,:,oBin.iBin) = mean(tsROI(:,:,binDepths),3);
	
	vbGoodBins(oBin.iNum) = any(binDepths);
end

[ voBins , nBins ] = NumStruct(voBins(vbGoodBins));
 
 oROI.voBins = voBins;

%% Make oBin ROIs
if defined('bDebugMode') && bDebugMode
	for oBin = voBins
		% Depth range string
		sRange = [num2str(oBin.lower), '-', num2str(oBin.upper)];
		
		binCoords = indices2Coords(VolumeIndices(view.sessionCode, binDepths), viDim);
		view = newROI(view, [ROIName, 'Depth', sRange], 'select', '', binCoords);
		
		% Add to voBins structure
		voBins(oBin.iBin).oROI = view.ROIs(end); % Add ROI to structure
	end
	
	saveAllROIs(view, 'local', 'force');
end

%% Bootstrap oParams
disp(['Attempting ', num2str(nBootstraps), ' bootstraps...']);
% oHrfs = [];

% disp('Bootstrapping...')
viBins= [voBins.iBin];
ts = squeeze(tsBinned(:,:,viBins));

% zero point
voMeanHRFs = HRFAnalysis2(ts, period);
zeroPoint = voMeanHRFs.zeroPoint;

% Preallocate
moBootParams = repmat(voMeanHRFs.voParams, [nBootstraps 1]);
mHRFs = nan([nBootstraps, size(voMeanHRFs.vY)]);
nTrials = size(ts, 2);

% Bootstrap iteration loop
for iStrap = 1 : nBootstraps
	% 1. Resample data - sample with replacements the trial numbers
	vResampledTrials = randsample(nTrials, nTrials, 'true');
	
	% Mean across resampled trials, TimeSamples x nTrials
	mResampledData = ts(:, vResampledTrials, :);
	oAnal = HRFAnalysis2(mResampledData, period, zeroPoint, interpSampleFactor);
	
	%Get HRFs
	mHRFs(iStrap,:,:) = oAnal.vY(:,:);
	%Get HRF parameters
	moBootParams(iStrap, :) = oAnal.voParams(:);
	
	TimedWaitbar(iStrap/nBootstraps, 'Bootstrapping over trials');
end % Bootstrap loop

oHrfs = CalcStats(mHRFs);

omBootParams = HRFStructArray2Struct(moBootParams);
oParams = ForEachFieldOf(omBootParams, @CalcStats);

%% Output
oResults = Struct(oParams, oHrfs, voMeanHRFs, oROI);
Save(['BootHRFAnalysis-', ROIName], oResults);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
