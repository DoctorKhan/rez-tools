% SplitROIByMapAlln
%
% Khan 10/14/2011

%% Initialize
HemoInit

%% Default params

%% Main
for oHemo = voHemo
	cds(oHemo);
	oView = InitHidden('Volume', 'Timed');
% 	oView = NormalizedDepthMap(oView, 'Load');
	
	for oBaseROI = voBaseROIs
		oROI = Load(SessionDir('Gray', 'ROIs', oBaseROI));
		if isempty(oROI)
			Str('Warning: Found empty ROI', oROI)
			continue;
		end
		oView = SplitROIByMap(oView, oROI, voCurvBins,  'Curvature', '', 'save');
		oView = SplitROIByMap(oView, oROI, voThickBins, 'Thickness', '', 'save');
		oView = SplitROIByMap(oView, oROI, voRegBins,  'Normalized', '', 'save');
	end
	
	clear global
	clear oView
end

%% Note: type "doc hungarian" for variable prefix explanation.
