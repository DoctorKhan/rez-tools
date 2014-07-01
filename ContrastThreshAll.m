function ContrastThreshAll(percent, voROIs, voHemos)
%
%
%
% Khan 07/11/2011

%% Default params


%% Initialize
HemoInit

%% Main
for oHemo = voHemos
	close all; clear global
	cds(oHemo);
	oGray = initHiddenGray;
	
	for oROI = voROIs;
		% Load and select ROI
		oGray.ROIs = Load(SessionDir('Gray', 'ROIs', oROI));
		if isempty(oGray.ROIs)
			warning(Str(oROI.iNum, ':', oROI.name, 'empty'))
			continue
		end
		disp(Str(oROI.iNum, ':', oROI.name))
		oGray = ContrastThresholdROI(oGray, 1, percent);
	end
	
	clear global
	clear oGray
end

end %function
%% Note: type "doc hungarian" for variable prefix explanation.
