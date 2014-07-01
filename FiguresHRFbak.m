function [mhPlot, mhLegend, vhFig, voLoad] = FiguresHRFbak(xROI, iTypeDef, oHemo, viBins, vScale, iPolyFit)

% vhAxes = FiguresHRF(oHemo, oROI, voBins, viBins);
%
% Plots the result of StandardAnalysisHemo
%
% Khan 07/29/2011

%% Initialize
%% Defaults
Default iTypeDef = 1 & iPolyFit = 1 & oHemo = HemoFromDir

if notDefined('xROI')
% 	pLatest = latest('BootHRFAnalysis-*.mat');
% 	if ~isempty(Load(pLatest, 'oROI'))
% 		xROI = pLatest;
% 	else
		cds(oHemo)
		[name, path] = uigetfile(pwd, 'Select data file');
		cd(path);
		xROI.filename = name;
		xROI.name = FileExt(name, '');
% 	end
	Str(xROI);
end

if ischar(iTypeDef)
	if iTypeDef == 'c'; close all; end
	if length(Ls(xROI)) > 1
		Ls(xROI)
		return
	else
		iTypeDef = 1;
	end
end

%% Arg handling
iTypeDef = str2int(iTypeDef);
if isstruct(xROI)
	if isLongVector(xROI) || exist(StructName(xROI), 'file')
		voFiles = xROI;
	else
		voFiles = Ls(['*' StructName(xROI) '*']);
	end
elseif ischar(xROI)
	voFiles = sl(xROI);
end

voFiles = Str2Struct(sort({voFiles.name}));
voFiles = voFiles(CellMatch({voFiles.name}, '\.mat$'));

for oFile = voFiles
	[oLoad, pFile] = Load(oFile);
	if isLongVector(oLoad)
		oLoad = oLoad(iPolyFit);
	end
	
	hFig = figure; sFig = [num2str(hFig), ': '];
	Str('Figure', sFig, oHemo.sSubject, DecodeHemoName(oFile, 'sTitle'))
	
	try
% 		Destruct oLoad -> omBootParams oParams voHrfs voFit oROI
% 	catch
% 		oLoad = FixFitParams(voFiles, oHemo);
% 		FixHemoFields(oHemo, voFiles);
		Destruct oLoad -> omBootParams oParams voHrfs voFit oROI
	end
	voBins = oROI.voBins;
	
	% Plot type
	if DecodeHemoName(oFile, 'nDepth') == 3
		iType = 2;
	else
		iType = iTypeDef;
	end
	
	if ~isempty(DecodeHemoName(oFile, 'sLower'))
		d=DecodeHemoName(oFile);
		thick = mean([str2double(d.sUpper); str2double(d.sLower)]);
	end
	
	Default thick = 1
	
	switch(iType)
		case {1,2}
			if defined('voFit')
				
				[cmParams, csParams] = Struct2Cell(oParams);
				
				voPlotData = HorzVec(cell2mat(cmParams));
				voFields = Str2Struct(csParams);
				
				voPlotData = CopyStruct(voPlotData, voFields);
				voPlotData = CopyStruct(voPlotData, voFit);
				
				nParams = length(voPlotData);
				nPlots = nParams + 1;
				
				if notDefined('vScale')
					vScale = ones(1, nPlots);
				end
				
				%% Initialize
				HemoInit
				vScale = 2./vScale;
				ivOrder = 1:8;
				
				for ii = 1:nParams
					voPlotData(ii).scale = vScale(ii);
					voPlotData(ii).lowerBar = voPlotData(ii).mean - voPlotData(ii).lower;
					voPlotData(ii).upperBar = voPlotData(ii).upper - voPlotData(ii).mean;
					voPlotData(ii).hPlot = subplot(2,4,ivOrder(ii));
				end
				
				cds(oHemo);
				
				if isempty(voPlotData(1)), return; end
				
				%% Set same scale - Midpoint shift
				mY = squeeze(cell2mat({voPlotData.mean}')); % mean params
				vL = squeeze(nanmean(cell2mat({voPlotData.lowerBar}'),2)); % mean lower
				vU = squeeze(nanmean(cell2mat({voPlotData.upperBar}'),2)); % mean upper
				
				% Min and max y values
				iDim = ~(MatchDims(mY, vL)-1)+1;
				mWindow = [Min(mY, iDim) - vL, Max(mY,iDim) + vU];
				vHalfWin = diff(mWindow')/2;
				vMid = nanmean(mWindow,iDim);
				
				mYLim(:,1) = vMid(:) - VertVec(vScale(1:7).*vHalfWin);
				mYLim(:,2) = vMid(:) + VertVec(vScale(1:7).*vHalfWin);
				if any(~isfinite(mYLim(:))), keyboard; end
				
				SetSize(930, 470, hFig);
				
				csParams = HorzVec(fieldnames(oParams));
				csParams = regexprep(csParams, '^PeakValue$', 'PeakAmplitude');
				csParams = regexprep(csParams, '^PeakTime$', 'TimeToPeak');
				
				% Labels
				for iParam = 1:7
					voLabels(iParam).y = SplitByCase(csParams{iParam});
					voLabels(iParam).x = 'Distance (normalized)';
					voLabels(iParam).title = '';
					% 	voLabels(iParam).legend = {Str('p =', p(iParam)), Str('s =', cvM{iParam})};
				end
				
				voLabels(1).title = ['Subject: ' oHemo.sSubject, ' ', oHemo.sSession];
				voLabels(3).title = ['ROI: ' DecodeHemoName(oROI.name, 'sTitle')];
				voLabels(4).title = oROI.comments;
				
				% Prealloc
				vhPlot = [voPlotData.hPlot]; vhLegend = 0*vhPlot;
				
				iMaxOrder = length(voPlotData(1).vP);
				sCr = CarriageReturn;
				sPm = char(177);
				for oParam = voPlotData
					iParam=oParam.iNum;
					
					sText=[]; sFitOrd = '';
					
					for iFitOrder = 1 %:iMaxOrder
						if iMaxOrder > 1, sFitOrd = num2str(iFitOrder); end
						
						sP = RoundSig(oParam.vP(iFitOrder), 2, 'string');
						sM = RoundSig(oParam.vFitParams(iFitOrder)/thick, 2, 'string');
						sText = Str(sText, sM, sPm, sP);
					end
					
					[vhPlot(iParam), vhLegend(iParam)] = PlotWithError(oParam, voBins, voLabels(iParam), oParam.hPlot, iType, thick);
					
					ylim(mYLim(iParam, :)); hold on
					
					vErrWin = nanmean(oParam.upper - oParam.lower);
					
					errWinFrac = .2;
					scale = vErrWin/errWinFrac;
					
					ylim(ScaleWin(ylim, scale));
					
					v = ylim;
					
					switch iType
						case 1
							v(1)  = min([oParam.mean v(1)]);
							v(2)  = max([oParam.mean v(2)]);
							
						otherwise
							v(1)  = min([oParam.lower v(1)]);
							v(2)  = max([oParam.upper v(2)]);
					end
					
					ylim(v);
					
					sText(end) = [];
					sLoc = 'best';
					
					hLegend = legend(sText, 'location', sLoc);
					set(hLegend, 'Visible', 'off');
					vBox = get(hLegend, 'Position');
					vBox = vBox + [ .01, 0, 0, 0];
					
					hA(iParam) = annotation('textbox', vBox, 'String', sText);
					set(hA(iParam), 'FitBoxToText', 'on', 'LineStyle', 'none')
				end
			end
			
			iParam = 8; oROI.filename = pFile;
			
			[vhPlot(iParam), vhLegend(iParam)] = PlotBinHrfs(oROI, subplot(2,4,ivOrder(iParam)));
			
		case 3
			mBootUndershoot = omBootParams.UndershootTime;
			close all; vFRange = [.4 .8];
			vFrac = normalize(1:size(mBootUndershoot,2));
			viFrac = vFrac > vFRange(1) & vFrac < vFRange(2); figure
			vData = restrict(mBootUndershoot(:,viFrac), 1, 28, 'remove');
			% 			vData = restrict(mBootUndershoot(:,viFrac), 11, 19, 'remove');
			histfit(vData,40);
			[mu,sigma,muci,sigmaci] = normfit(vData);
			% 			hist(restrict(mBootUndershoot(:,viFrac), 19, 28, 'remove'),40);
			return
		otherwise
			error('Invalid iType');
	end
	
	if ~defined('vhFig')
		nFigs = oFile.nTot;
		mhPlot = repmat(vhPlot, [nFigs, 1]);
		mhLegend = repmat(vhLegend, [nFigs, 1]);
		voLoad = repmat(oLoad, [nFigs, 1]);
		vhFig = repmat(hFig, [nFigs, 1]);
	else
		mhPlot(oFile.iNum,:) = vhPlot;
		mhLegend(oFile.iNum, :) = vhLegend;
		voLoad(oFile.iNum) = oLoad;
		vhFig(oFile.iNum) = hFig;
	end
end

% SameAxes(mhPlot);

for hFig = HorzVec(vhFig)
	figure(hFig); figure(hFig); pause2(2);
end

end % function


%% Note: type "doc hungarian" for variable prefix explanation.


%%
% 				viTimes = CellMatch(csParams, 'Time|FWHMValue');
% 				viVals = setdiff(CellMatch(csParams, 'Value'), viTimes);
% 				iUnder = CellMatch(csParams, 'UndershootTime');
% 				viT2 = setdiff(viTimes, iUnder);

% 			set(vhLegend(iParam), 'Visible', 'off');
% 			yMax = max([voHrfs(viBins).upper]);
% 			yMin = min([voHrfs(viBins).lower]);

% 			yMid = (yMin + yMax)/2;
% 			halfWin = yMax - yMid;

% 			yTop = yMid + vScale(iParam)*halfWin;
% 			yBot = yMid - vScale(iParam)*halfWin;

% 			ylim([yBot yTop]); hold on


% 	hx = get(gca, 'XLabel');
% 	set(hx, 'units', 'normalized')
% 	vx = get(hx, 'position');
% 	vBox = get(gca, 'position') + [ .01, -.01, 0, 0 ];

% if ishandle(1) && ishold, close all; end
% 				ivOrder = [ 6 3 2 5 8 4 7 1 ];
% 				viOrder = [ 3 5 7 1 2 4 6 ];
