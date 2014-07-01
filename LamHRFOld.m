function [oResults, oThreshedROI] = LamHRFOld(oView, oBaseROI, cnr, voBins, tsSliceBlock, vNormMap, nBoots)

% LamHRF;
%
%
%
% Khan 07/26/2011

%% Default params


%% Initialize
HemoInit

vAllCnr = 80:-20:20;
vCnrIndexMap(vAllCnr) = 1:4;
iCNR = vCnrIndexMap(cnr);

oROINames  = load(['csROIs.' oBaseROI.sROI, '.mat']);
voROINames = cell2struct(oROINames.csROIs, 'sROI')';

%% Main
sThreshROIName = voROINames(iCNR).sROI;

% Load ROI
disp(['Loading ROI ', sThreshROIName, '...']);
oThreshedROI  = getfield(load(SessionDir('Gray', 'ROIs', sThreshROIName)), 'ROI');

% Mark it through depth
[~, vbROIMask] = MarkLaminarROI(oView, oThreshedROI);

% Good voxels mask
vSum = squeeze(sum(sum(tsSliceBlock,1),2));
vbFinite = isfinite(vSum);
vbGoodDepths = vNormMap >= -1 & vNormMap <=2;
vbNonzero = vSum ~= 0;

vbFinalMask = vbROIMask(:) & vbFinite(:) & vbGoodDepths(:) & vbNonzero(:);

if total(vbFinalMask) == 0
    error('Empty mask');
end

tsROI = tsSliceBlock(:,:,vbFinalMask);
vROIDepth = vNormMap(vbFinalMask);

if any(~isfinite(tsROI(:)))
    warning(1, 'Nonfinite value in ROI.');
    keyboard
end

viDim = GetDimFromAnat;
oThreshedROI.FinalCoords = ind2sub3d(VolumeIndices(oView.sessionCode, vbFinalMask), viDim);

%% Stack session events
[tsBinned, voBins] = StackJitteredSessionEvents(tsROI, vROIDepth, sThreshROIName, voBins, oView);
% tsSliceBlock = NormSliceBlockByMeanGray(tsSliceBlock, trialPeriod, vbDomain);

% Bootstrap & Analysis
[oBootAnalysis, ~, oHRFAnalysis, moBootHRFs] = LaminarHRFAnalysis(tsBinned, voBins, sThreshROIName, nBoots, 'Norm', 'force');

oResults = Struct(oBootAnalysis, voBins, oHRFAnalysis, moBootHRFs);

save(['BootHRFAnalysis-', sThreshROIName], 'oResults');
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
