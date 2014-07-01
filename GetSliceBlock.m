function [tsSliceBlock, mbFinite, view] = GetSliceBlock(view, vScanList, sDataType, sViewType, pSaveFile, vbDejitter)

% [tsSliceBlock, mbFinite] = GetSliceBlock(view, vScanList, sDataType, sViewType, pSaveFile);
%
%
%
% Khan 07/21/2011

mrGlobals

%% Default params
% Default view = getSelectedView
Default vScanList = 1:HRFInfo('nScans')
Default pSaveFile = "SliceBlock" | sDataType = "Timed" | sViewType
Default vbDejitter = true(size(vScanList))
Default view = initHiddenVolume

%% Initialize
if notDefined('view.anat'), view = loadAnat(view); end
oInfo = HRFInfo;

if strcmpi(sViewType, 'gray')
	error('This calculation requires a Volume view')
end

if defined('sDataType')
	view = selectDataType(view, sDataType);
end

framePeriod = oInfo.framePeriod;
% Number of samples taken per trial. e.g. 18
% Find total events in all scans:
nFramesPerTrial = oInfo.nFramesPerTrial;
nTrialsPerScan = oInfo.nTrialsPerScan;
nScans2Load = length(vScanList);

%% Main
TimedWaitbar(0);
sView = view.viewType;

% zeros(nFramesPerTrial, nTrialsPerScan, [], nScans2Load);

[~, tSeries] = percentTSeries(view, 1, 1);
tSeries = reshape(tSeries, nFramesPerTrial, nTrialsPerScan, []);
t4dSliceBlock = repmat(tSeries, [1 1 1 nScans2Load]);

for iScanNum = 1:nScans2Load
	iScan = vScanList(iScanNum);
	
	disp(['Stacking events for ', sDataType ' data in the ', sView, ' view. Scan: ', num2str(iScan)]);
	[~, tSeries] = percentTSeries(view, iScan, 1);
	tSeries = reshape(tSeries, nFramesPerTrial, nTrialsPerScan, []);
		
	disp(['Jitter correcting for ', sDataType ' data in the ', sView, ' view. Scan: ', num2str(iScan)]);
	
	if HRFInfo('jitter') && vbDejitter(iScanNum)
		tSeries = JitterCorrect(tSeries, framePeriod, iScan, oInfo);
	end
	
	t4dSliceBlock(:,:,:,iScanNum) = tSeries;

	TextWaitbar(iScanNum/nScans2Load, Str(fin(tSeries)*100, '% finite.'));
end

t4dSliceBlock = permute(t4dSliceBlock, [1 2 4 3]);
tsSliceBlock = CollapseDims(t4dSliceBlock, [2 3]);

mbFinite = squeeze(all(isfinite(tsSliceBlock)));
if isempty(tsSliceBlock); warning(1, 'empty sliceblock'); end

%% Save
disp('Saving data...')
Save(pSaveFile, tsSliceBlock, mbFinite, vScanList, sDataType);
disp('New slice block saved.');
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
