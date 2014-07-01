function [ tFiniteSeries, tbFinite ] = FindFiniteTimeSeries(tsSliceBlock)

% [ mFiniteCoords, vbFiniteMap, tsFinite ] = FindFiniteTimeSeries(oView, tsSliceBlock);
%
%
%
% Khan 07/20/2011

mrGlobals
%% Default params
DefaultView

%% Initialize
% nVoxels = viDim(end);
nFramesPerTrial = size(tsSliceBlock, 1);
%% Main
ts = sum(tsSliceBlock, 1);
mbFinite = isfinite(ts);
tbFinite = repmat(mbFinite, [nFramesPerTrial, 1 1];
disp([num2str(RoundTo(fraction(vbFiniteMap)*100,1)), '% of the volume or gray voxels were finite']);
% mFiniteCoords = reshape(oView.coords(repmat(vbFiniteMap, 3, 1)), 3, []);

tFiniteSeries = nansize(tsSliceBlock);
tFiniteSeries(tbFinite) = tsSliceBlock(tbFinite);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
