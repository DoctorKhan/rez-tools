% TestMakeLamCols;
%
%
%
% Khan 08/12/2011

%% Default params


%% Initialize
%%
nBins = length(voBins); nFramesPerTrial= size(tsROI, 1); nTrials = size(tsROI, 2);
tsBinned = zeros(nFramesPerTrial, nTrials,  nBins);

% Remove empty voBins

vbGoodBins = logical(size(voBins));
for oBin = voBins;
	binDepths = (roiDepth >= oBin.lower & roiDepth < oBin.upper);
	tsBinned(:,:,oBin.iBin) = mean(tsROI(:,:,binDepths),3);
	
	vbGoodBins(oBin.iNum) = any(binDepths);
end

[ voBins , nBins ] = NumStruct(voBins(vbGoodBins));
 
 oROI.voBins = voBins;



%% Note: type "doc hungarian" for variable prefix explanation.
