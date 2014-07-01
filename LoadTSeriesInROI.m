function [tsInROI, mROICoords, viMask] = LoadTSeriesInROI(oView, mROICoords, iScanNum, iSlice, iEcho)

% LoadTSeriesInROI;
%
%
%
% Khan 07/20/2011

%% Default params
Default oView=getSelectedView mROICoords=oView.coords iSlice iEcho iScanNum=1

%% Initialize
if isempty(mROICoords), error('Empty coords.'); end

%% Main
ts = loadtSeries(oView,iScanNum, iSlice, iEcho);    
[mROICoords, viMask] = intersectCols(oView.coords, mROICoords);
tsInROI = ts(:, viMask);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
