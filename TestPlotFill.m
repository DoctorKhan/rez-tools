% function TestPlotFill

% TestPlotFill;
%
%
%
% Khan 01/08/2012
 
%% Default params


%% Initialize


%% Main
close all; figure; hold on
voFiles = Ls('BootHRF*V1pt*');
oColor = ColorMapper(voFiles(1));
voFiles = oColor.GetColors(voFiles);
sParam = 'PeakValue';

for oFile = voFiles
	Load(oFile);
	vX = [oROI.voBins.middle];
	oFit = voFit(CellMatch(fieldnames(oParams), sParam));
	PlotFill(vX, [oParams.(sParam)], oFile.color, oROI.meanThick, oFit);
end

xlabel('Height Above Gray/White (mm)');
ylabel(Str(SplitByCase(sParam)));
title(DecodeHemoName(oFile, 'sTitle'));

PlotFillMulti(vX, oY);


% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
