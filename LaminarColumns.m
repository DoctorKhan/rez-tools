function [oStats, oData, oMaps, oView] = LaminarColumns(oView, oHemo, binSpacing)

% [oStats, oData, oMaps, oView] = LaminarColumns(oView, oHemo);
%
%
%
% Khan 01/16/2012
 
%% Default params
HemoInit
cds oHemo
Default oView = initHiddenVolume;

Default binSpacing = 1.5; % voxels

%% Initialize

% if isstruct(coords), coords = coords.coords; end
voxSize = GetVoxelSize(oHemo, 'func');

oView = LoadLaminarIndices(oView);
[oView, oMaps] = LoadNormDepthMap(oView, oHemo);


nCols = length(oView.laminarIndices);
vnVoxels = CellFun(@length, oView.laminarIndices);
nMaxVoxels = max(vnVoxels);

% mCols = ones(nMaxVoxels, nCols);

%% Main
vi = VolumeIndices(oHemo);
gi = GrayIndices(oHemo);

% mCols(~ismember(mCols(:), viGray)) = 1;

% Preallocate
% viOutside = 1:(300^2);
% setdiff(mCols(:), vi(:));
% vDepth(viOutside) = nan;

vDepth = oMaps.vPhysMap./voxSize;
viMap(vi) = 1:length(vi);
% vNorm(vi) = oMaps.vNormMap;
cvInds = oView.laminarIndices;
cvDepths = cvInds;

for iCol = 13103 %1:nCols
	viCol0 = cvInds{iCol};
 	viCol = intersect(viCol0, gi);
	
	viVol2Map = viMap(viCol);
	viVol2Map(viVol2Map == 0) = [];
	vDepthCol = vDepth(viVol2Map);
	cvDepths{iCol} = vDepthCol;

	[lower upper] = Bounds(vDepthCol);
	nBins = round((upper-lower)/binSpacing);
	vBins = linspace(lower, upper, nBins+1);
	
	try
		vHist = HistCount(vDepthCol, vBins);
	catch
		keyboard
	end
	cvBins{iCol} = vBins;
	cvHist{iCol} = vHist;

	vMean(iCol) = mean(vHist);
	vStd(iCol) = std(vHist);
	
	vBins2 = min(vDepthCol):binSpacing:max(vDepthCol);
	vHist2 = histc(vDepthCol, vBins2);
	vMean2(iCol) = mean(vHist2);
	vStd2(iCol) = std(vHist2);
	TextWaitbar(iCol/nCols);
end

vQuality = vStd./vMean; 
vQuality2 = vStd2./vMean2;
oStats = Struct(vMean, vStd, vQuality, vMean2, vStd2, vQuality2);
oData = Struct(cvDepths, cvHist, cvBins, cvInds);

end % Function
 
%% Note: type "doc hungarian" for variable prefix explanation.
