% function TestPlotFillMulti

% TestPlotFillMulti;
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

clear voY;

for oFile = voFiles
	Load(oFile);
	oY = [oParams.(sParam)];
	oY.label  = Str(SplitByCase(sParam));
	oY.oFit   = voFit(CellMatch(fieldnames(oParams), sParam));

	o = DecodeHemoName(oFile);
	oY = CopyStruct(oY, o, 'middle', 'sMiddle', 'sType');
	voY(oFile.iNum) = CopyStruct(oFile, oY);
end

% x
vX = [oROI.voBins.middle];
scale = oROI.meanThick;
label = 'Height Above Gray/White (mm)';
oX = Struct(vX, scale, label);

% Plot
sTitle = DecodeHemoName(oFile, 'sShort');
PlotFillMulti(oX, voY, sTitle, 'legend');

% csMids = CellFun(@num2str, {voY.middle})';

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
