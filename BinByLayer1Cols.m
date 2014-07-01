function [ts, oROI] = BinByLayer1Cols(oROI, tsROI, view)

% oROI = BinByLayer1Cols(oROI, tsROI);
%
%
%
% Khan 08/15/2011

%% Default params
Default view = initHiddenGray
view = loadSpatialGradient(view);
if notDefined('tsROI')
	if ~isfield(view, 'tSeries') || isempty(view.tSeries)
		view.tSeries = loadtSeries(view, '', '', '', 'Timed');
	end
	tsROI = getTSeriesROI(view, oROI.coords);
end

%% Initialize
ROIName = [oROI.name, 'l'];
viDim = GetDimFromAnat;

%% Main
% Preallocate
[ ~, viLayer1Indices, cviLaminarIndices ] = LoadLayer1(view);

viROIVolIndices = sub2ind3d(oROI.coords, viDim);
[~, viROILayer1] = intersect(viLayer1Indices, viROIVolIndices);
cviROIIndices = cviLaminarIndices(viROILayer1);

nSurfVoxels = length(cviROIIndices);
nFramesPerTrial= size(tsROI, 1);
nTrials = size(tsROI, 2);
ts = zeros(nFramesPerTrial, nTrials,  nSurfVoxels);

for iSurfVox = 1:nSurfVoxels
	viLaminarIndices = cviROIIndices{iSurfVox};
	[~, viCol] = intersect(viROIVolIndices, viLaminarIndices);
	ts(:,:,iSurfVox) = mean(tsROI(:,:,viCol), 3);
end

oROI.name = ROIName;
oROI.cviLaminarIndices = cviROIIndices;

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
