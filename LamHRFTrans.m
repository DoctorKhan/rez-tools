function oResults = LamHRFTrans(view, oROI, tSliceBlock, vNormDepthMap, mResamp)

% oResults = LamHRF(view, oBaseROI, cnr, voBins, tSliceBlock, vNormDepthMap, nBootstraps);
%
% Laminar HRF Analysis simpler
%
% Khan 07/26/2011

%% Default oParams
%% Initialize
nBootstraps = size(mResamp, 2);
interpSampleFactor = 0.05; % Inverse factor to be multiplied by the period to generate the number of interpolated points
period = HRFInfo('trialPeriod');

%% Mark ROI through depth
vbROIMask = Coords2Log(oROI.coords, view);		

% Good voxels mask
sumTS = squeeze(sum(sum(tSliceBlock,1),2));
fints = isfinite(sumTS);
goodDepths = vNormDepthMap >= -1 & vNormDepthMap <=2;
nonzeroTS = sumTS ~= 0;

finalMask = vbROIMask(:) & fints(:) & goodDepths(:) & nonzeroTS(:);
if total(finalMask) == 0, error('Empty mask'); end

tsROI = tSliceBlock(:,:,finalMask);
if any(~isfinite(tsROI(:))), error(1, 'Nonfinite value in ROI.'); end

oROI.coords = VolMask2Coords(finalMask, view);
oROI.name = [oROI.name, 'M'];

%% Make voBins
disp('Binning by laminar index.')
[ts, oROI] = BinByTrans(oROI, tsROI, view);

%% Bootstrap oParams
disp(['Commencing ', num2str(nBootstraps), ' bootstraps...']);

% zero point
voMeanHRFs = HRFAnalysis(ts, period);
zeroPoint = voMeanHRFs.zeroPoint;

% Preallocate
moBootParams = repmat(voMeanHRFs.voParams, [nBootstraps 1]);
mHRFs = nan([nBootstraps, size(voMeanHRFs.mY)]);

sWindowTitle = ['Progress', CurrentDesktop(' : ')];

% Bootstrap iteration loop
for iStrap = 1 : nBootstraps
	% 1. Resample data - sample with replacements the trial numbers
	vResampledTrials = mResamp(:,iStrap);
	
	% Mean across resampled trials, nTimeSamples x nTrials x nBins
	mResampledData = ts(:, vResampledTrials, :);
	
	oAnal = HRFAnalysis(mResampledData, period, zeroPoint, interpSampleFactor);
	
	%Get HRFs
	mHRFs(iStrap,:,:) = oAnal.mY(:,:);
	%Get HRF parameters
	moBootParams(iStrap, :) = oAnal.voParams(:);
	
	TimedWaitbar(iStrap/nBootstraps, 'Bootstrapping over trials', ...
		'name', sWindowTitle);
end % Bootstrap loop
disp Done.

oHrfs = CalcStats(mHRFs);

omBootParams = HRFStructArray2Struct(moBootParams);
oParams = ForEachFieldOf(omBootParams, @CalcStats);
% fraction(isfinite(struct2mat(oParams)))

oResults = Struct(omBootParams, oParams, oHrfs, voMeanHRFs, oROI);
Save(['BootHRFTrans-', oROI.name], oResults);
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
