function oMap = FiguresHRF(oROI, voPar, oMetric, oHemo, oMap, varargin)

% vhAxes = FiguresHRF(oHemo, oROI, voBins, viBins);
%
% Plots the result of StandardAnalysisHemo
%
% Khan 07/29/2011

%% Initialize
% Options: oHemo, vScale, iPolyFit
% [oHemo, vScale, iPolyFit] = Option(@isHemo, @isNumVector, @isNumScalar);

Default oMetric & oMap
sMetric = StructName(oMetric);

%% Defaults
HemoInit
Default iTypeDef = 1 & iPolyFit = 1 & oHemo = HemoFromDir
% oHemo = HemoFromDir;
% cds(oHemo)

if isequal(iTypeDef, 'c'), close all; end
if defined('sMetric') && ~strcmpi(sMetric, 'whole')
	sMetric = lower(sMetric(1));
else
	sMetric = '[u.]';
end
%% Arg handling


% Sort and filter
if notDefined('oROI') || strcmpi(oROI, 'latest BootHRFAnalysis*mat')
	sFiles = latest('BootHRFAnalysis-*mat');
elseif ischar(oROI)
    sFiles = oROI;
else
    sFiles = ['*' oROI.name sMetric '*mat'];
end

voFiles = Ls(TryExt(sFiles));

ciDims = {1,2};
oFile = voFiles(1);

oRes = load(oFile.name, 'oResults');
oRes = oRes.oResults;
oParams = oRes.oParams;
oROI = oRes.oROI;
% [oParams oROI] = load(oFile, 'oParams', 'oROI');
% ivOrder = [ 2 5 6 3 4 7 8 1 ];

csParams = fieldnames(oParams);

for oPar = voPar
	hFig = figure; sFig = [num2str(hFig), ': '];
	Str('Figure', sFig, oHemo.sSubject, DecodeHemoName(oFile, 'sTitle'))
	
	if regexpi(oPar.name, 'hrf')
		for oFile = voFiles
			oROI.filename = oFile.name;
			hPlot = subplot(1, oFile.nTot, oFile.iNum);
			[~, ~, oMap] = PlotBinHrfs(oROI, hPlot, oMap);
		end
	else
		[~, csFigParams] = CellMatch(csParams, oPar.name);
		for oParam = Str2Struct(csFigParams)
			subplot(ciDims{:}, oParam.iNum);
			if oParam.iNum == 1
				HemoMultiPlot(voFiles, oParam, 'title', 'legend');
			else
				HemoMultiPlot(voFiles, oParam, '', 'legend');
			end
		end
    end %if

    SetSize(800, 300, hFig);

end %for



end % function


%% Note: type "doc hungarian" for variable prefix explanation.
