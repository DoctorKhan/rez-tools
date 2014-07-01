function [oView, oResults] = LamHRF(oView, xROI, voDepthBins, tsSliceBlock, oMaps, mResamp) %#ok<STOUT>

% [oView, oResults] = LamHRF(oView, xROI, voDepthBins, tsSliceBlock, vNormDepthMap, mResamp) %#ok<STOUT>;
%
% Laminar HRF Analysis simpler
%
% Khan 07/26/2011

HemoInit
%% Default
if defined('oView')
	oView = Switch2('Volume', oView, 'Timed');
else
    if defined('tsSliceBlock')
    	oView = InitHidden('Volume', 'Timed');
    else
        oView = InitHidden('Volume', 'Timed', 'SliceBlock');
    end
end

Default tsSliceBlock = oView.tsSliceBlock
if notDefined('mResamp') && exist('BootstrapIndices.mat', 'file'), load('BootstrapIndices'); end

if notDefined('oMaps') || notDefined('oView')
	[oView, oMaps] = NormalizedDepthMap(oView);
end

Destruct oMaps -> vNormMap vThickMap
oHemo = HemoFromDir; 

%% Arg handling
if isInt(xROI)
    oROI = oView.ROIs(xROI);
else
    xROI = StructName(xROI);
    load(SessionDir('Gray', 'ROIs', xROI));
    oROI = ROI;
end

%% Initialize
% if strcmpi(StructName(oROI), 'LaminarV1pc(0p082225-0p18222)u50')
% 	keyboard
% end

[oView, oMaps] = LoadNormDepthMap(oView, oHemo);
Default vNormDepthMap = oMaps.vNormMap;
Str('Beginning', oROI, 'laminar analysis...')
nBootstraps = size(mResamp, 2);
interpSampleFactor = 0.05; % Inverse factor to be multiplied by the period to generate the number of interpolated points
period = HRFInfo('trialPeriod');

%% Mark ROI through depth
vbROIMask = sub2mask(oROI.coords, oView.coords); %VolumeCoords

% Good voxels mask
sumTS = squeeze(sum(sum(tsSliceBlock,1),2));
% fints = isfinite(sumTS); % same as any(~isfinite(tsSlice...
goodDepths = vNormDepthMap >= -1 & vNormDepthMap <=2;
nonzeroTS = sumTS ~= 0;

finalMask = vbROIMask(:) & goodDepths(:) & nonzeroTS(:);
if total(finalMask) == 0, error('Empty mask'); end

tsROI = tsSliceBlock(:,:,finalMask);
% if any(~isfinite(tsROI(:))), error(1, 'Nonfinite value in ROI.'); end

oROI.coords = VolMask2Coords(finalMask, oView);

%% Make voDepthBins
disp('Binning by depth.')
% Pass vNormDepthMap(finalMask) instead.
[voDepthBins, tsBinned] = BinByDepth(voDepthBins, tsROI, finalMask, vNormDepthMap);
[~, tsBinnedPlot8] = BinByDepth(voPlot8Bins, tsROI, finalMask, vNormDepthMap);
tsBinnedPlot8 = cat(1, tsBinnedPlot8, tsBinnedPlot8(1, :, :));
meanThick = NanMean(VertVec(vThickMap(finalMask)));

%% Bootstrap oParams
disp(['Commencing ', num2str(nBootstraps), ' bootstraps...']);

% zero point
oMeanHRFs = HRFAnalysis(tsBinned, period);
zeroPoint = oMeanHRFs.zeroPoint;

% Preallocate
moBootParams = repmat(oMeanHRFs.voParams, [nBootstraps 1]);
plotTSsize = size(tsBinnedPlot8);
mHRFs = nan([nBootstraps, plotTSsize([1, 3])]);

% ColumnProfiles;

tic; % Bootstrap iteration loop
for iStrap = 1 : nBootstraps
	% 1. Resample data - sample with replacements the trial numbers
	vResampledTrials = mResamp(:,iStrap);
	
	% Mean across resampled trials, nTimeSamples x nTrials x nBins
	mResampledData = tsBinned(:, vResampledTrials, :); %#ok<PFBNS>	
	mResampledDataPlot8 = tsBinnedPlot8(:, vResampledTrials, :); %#ok<PFBNS>	
	oAnal = HRFAnalysis(mResampledData, period, zeroPoint, interpSampleFactor);

	% Get HRFs
	mHRFs(iStrap,:,:) = NanMean(mResampledDataPlot8, 2);
	% Get HRF parameters
	moBootParams(iStrap, :) = oAnal.voParams(:);
    TextWaitbar(iStrap/nBootstraps);
end % Bootstrap loop
toc; disp('Done bootstrapping.')
TextWaitbar;
voHrfs = CalcStats(mHRFs);

omBootParams = HRFStructArray2Struct(moBootParams);
oParams = ForEachFieldOf(omBootParams, @CalcStats);
% mbFinBin = MixedMatch(vbGoodBins, squeeze(nanmean(Struct2Mat(omBootParams))));

% Fit data
voFit = LaminarFits(omBootParams, voDepthBins);

oROI.meanThick = meanThick;
oROI.voDepthBins  = voDepthBins;
oROI.vbMask  = finalMask;
oROI.nVoxels = total(finalMask);

%% Output
oResults = SaveHemo(omBootParams, oParams, voHrfs, oMeanHRFs, oROI, voFit, voDepthBins, voThickBins, voCurvBins, voPlot8Bins);

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
