function tsSliceBlock = GetSliceBlock2(oView, mROICoords, vScanList, pSaveFile)

% tsSliceBlock = GetSliceBlock(oView);
%
%
%
% Khan 07/21/2011

mrGlobals
%% Default params
Default oView=getSelectedView mROICoords=oView.coords
Default pSaveFile="SliceBlock"

%% Initialize some variables

nVoxels = size(mROICoords, 2);
framePeriod = mrSESSION.functionals(1).framePeriod; %e.g. 1.5 s between samples
%Number of samples taken per trial. e.g. 18
oHRFInfo = HRFInfo('', mrSESSION);
trialPeriod = oHRFInfo.period;
nFramesPerTrial = trialPeriod / framePeriod;

%% Find total events in all scans:
nFramesPerScan = mrSESSION.functionals(1).nFrames; TimedWaitbar(0);
nScans = oHRFInfo.nScans;

Default vScanList=1:nScans

%% Main
tsSliceBlock = nan(nFramesPerScan, nScans, nVoxels);

for iScanNum = vScanList
    [mTSeries, mROICoords] = LoadTSeriesInROI(oView, mROICoords, iScanNum);
    
    %e.g. 144 x 1 for 144 frames in scan.
    [vJitterData, bReadSuccess] = ReadJitterData('.', iScanNum); % Adjust for jitter
    if ~bReadSuccess; warning(1, 'Could not read jitter data.'); continue; end
    
    sMessage = ['Stacking session events for scan', num2str(iScanNum)];
    TimedWaitbar(0, sMessage); disp(sMessage)
    
    mTSeries = JitterCorrect(mTSeries, framePeriod, vJitterData);
    TimedWaitbar(iVoxel/nVoxels);
    
    tsSliceBlock(:,iScanNum, :) = mTSeries;
end

TimedWaitbar;
tsSliceBlock = reshape(tsSliceBlock, nFramesPerTrial, [], nVoxels);
if isempty(tsSliceBlock); warning(1, 'empty sliceblock'); end

%% Save
Save(pSaveFile, tsSliceBlock);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
