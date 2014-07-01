function oResults = SaveHemo(omBootParams, oParams, voHrfs, oMeanHRFs, oROI, voFit, voBins, voThickBins, voCurvBins, voPlot8Bins)

% oResults = SaveHemo(omBootParams, oParams, voHrfs, oMeanHRFs, oROI, voFit, voBins, voThickBins, voCurvBins);
%
%
% Khan 11/29/2011

%% Default params


%% Initialize
oResults = Struct(omBootParams, oParams, voHrfs, voPlot8Bins, oMeanHRFs, oROI, voFit);
sBoot = 'BootHRFAnalysis-';

%% Main
sDepthBins = [num2str(length(voBins)) 'D'];
sThickBins = [num2str(length(voThickBins)) 'T'];
sCurveBins = [num2str(length(voCurvBins)) 'C'];
sBins = [sDepthBins sThickBins sCurveBins '-'];

if strncmp(sBoot, oROI.name, 15)
	pSaveFile = regexprep(oROI.name, sBoot, [sBoot, sBins]);
else
	pSaveFile = [sBoot, sBins, oROI.name];
end

Str('*** Saving...   ', oROI)
Save(pSaveFile, oResults);

end

%% Note: type "doc hungarian" for variable prefix explanation.
