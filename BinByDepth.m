function [voBins, tsBinned, vbGoodBins] = BinByDepth(voBins, tsROI, finalMask, vNormDepthMap)

% [voBins, tsBinned, vbGood, vGoodDepths] = BinByDepth(voBins, tsROI, finalMask, vNormDepthMap);
%
%
%
% Khan 08/15/2011

%% Default params
%% Initialize
vRoiDepth = vNormDepthMap(finalMask);

%% Main
% Preallocate
nBins = length(voBins); 

% tsROI = nFramesPerTrial x nTrials
nFramesPerTrial= size(tsROI, 1); 
nTrials = size(tsROI, 2);
tsBinned = nan(nFramesPerTrial, nTrials,  nBins);

% vLower = [oBin.lower]; vUpper = [oBin.upper];
Str('Binning', lower(StructName(voBins(1))), 'into', length(voBins), 'bins...');
for oBin = NumStruct(voBins)
	vbVoxelsInBin = (vRoiDepth >= oBin.lower & vRoiDepth < oBin.upper);
	sLower = sprintf('%5.2f', oBin.lower);
	sUpper = sprintf('%5.2f', oBin.upper);
	sVoxels = sprintf('%5d', total(vbVoxelsInBin));
	disp([sVoxels ' voxels in bin [ ' sLower ' to ' sUpper ' ]']);
	% if any voxels exist in bin, take the mean time series over bin
	if any(vbVoxelsInBin)
		tsBinned(:,:,oBin.iNum) = nanmean(tsROI(:,:,vbVoxelsInBin),3);
		voBins(oBin.iNum).bGood = true;
	else
		% empty
		voBins(oBin.iNum).bGood = false;
	end
end

%% Output
vbGoodBins = [voBins.bGood];
% tsBinned = squeeze(tsBinned(:,:,vbGoodBins));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
