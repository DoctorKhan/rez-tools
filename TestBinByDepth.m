function TestBinByDepth

% TestBinByDepth;
%
%
%
% Khan 11/01/2011

%% Default params


%% Initialize
if notDefined('finalMask')
	load TestBinByDepths
end

%% Main
[voBins, tsBinned, vbGoodBins] = BinByDepth(voBins, tsROI, finalMask, vNormDepthMap);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
