function HemoMultiPlot(voFiles, sParam, sTitle, varargin)

% HemoMultiPlot(voFiles, sParam);
%
%
%
% Khan 01/09/2012
 
%% Default params
Default sParam = "PeakValue";
Default sTitle

%% Initialize
sParam = StructName(sParam);
if ischar(voFiles)
	voFiles = Ls(voFiles);
end

%% Main
% oColor = ColorMapper(voFiles(1));
% voFiles = oColor.GetColors(voFiles);

for oFile = voFiles
	Load(oFile);
	oY = [oParams.(sParam)];
	oY.label  = DecodeParam(sParam);
	oY.oFit   = voFit(CellMatch(fieldnames(oParams), sParam));

	o = DecodeHemoName(oFile);
	oY = CopyStruct(oY, o, 'middle', 'sMiddle', 'sType');
	voY(oFile.iNum) = CopyStruct(oFile, oY);
end

% x
vX = [oROI.voDepthBins.middle];
scale = 1; %oROI.meanThick;
label = 'Height Above Gray/White (mm)';
oX = Struct(vX, scale, label);

% Plot
if strcmpi(sTitle, 'title')
	sTitle = DecodeHemoName(oFile, 'sShort');
end
oLabels.x = oX.label;
oLabels.y = oY.label;
if ~Option('notitle')
oLabels.title = sTitle;
else
    oLabels.title = '';
end

s = basename(sessiondir);
sCode = TitleCase(s(7:end));
pDir = '/home/khan/ISMRM2012';
csParams = {'Width', 'Peak', 'Init', 'Under', 'Hrf'};

for oY = voY
    
%     oY.hPlot = figure;
    PlotWithError(oY, oX, oLabels); hold on
    FixFigLimits(1.2)
    
    [~, s] = SplitStr(sTitle);
    csParamsCheck = {'fwhm', 'Peak', 'Init', 'Under', 'Hrf'};
    csParams = {'Width', 'Peak', 'Init', 'Under', 'Hrf'};
    for ii = 1:5
    if regmatch(oY.label, csParamsCheck{ii})
        break
    end
    end
sName = [sCode s csParams{ii} '.'];
pName = fullfile(pDir, [sName, 'csv']);

   s = oY.oFit.vFitParams(1);
    p = oY.oFit.vP(1);
    sFitStat = Str('s =', RoundSig(s,2), ' p =', RoundSig(p,2));
  
sLabels = [oX.label ',Lower 68%,' oY.label ',Upper 68%,' sFitStat];
   dlmwrite(pName, sLabels, '')
   
 
   vYFit = interp1(VertVec(oY.oFit.vXf),VertVec(oY.oFit.vYf),vX);
   
   m = [VertVec(vX) VertVec(oY.lower) VertVec(oY.mean) VertVec(oY.upper) VertVec(vYFit)];
   dlmwrite(pName, m, '-append');


%     TriColoredPatch; hold on;
    PlotWithError(oY, oX, oLabels, gcf); hold on
    FixFigLimits
end

    
% FixFigLimits(1.2)
% a = xlim;
% xlim(a - [0 .2]);


% PlotFillMulti(oX, voY, sTitle, varargin{:});

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
