function [hAxisOut hLegend oMap] = PlotBinHrfs(oROI, hAxis, oMap, voBins2Show)

% [hAxisOut hLegend] = PlotBinHrfs(oROI, hAxis, voBins2Show);
%
%
%
% Khan 07/29/2011
%% Default params
HemoInit

Default voBins2Show = voThickBins

if isnumeric(voBins2Show)
	viSelectedBins = voBins2Show;
	voBins2Show = oROI.voBins(viSelectedBins);
end

% Plot
if notDefined('hAxis')
	hFig = figure;
	hAxis = gca(hFig);
end

%% Initialize
hAxisOut = 0; hLegend = 0; hold off
HemoInit

%% Main
% Load results
oMeanHRFs = Load(oROI, 'oMeanHRFs');
% if isempty(oMeanHRFs)
% 	oMeanHRFs = Load(oROI.filename, 'voMeanHRFs');
% end
Load(SessionDir(oROI));

vX = oMeanHRFs(1).vX;
% viDepths = [5 8 10 12 15];

xlabel('Time (s)'); ylabel('Percent Modulation');
% title(oROI.comment);

Default voBins = voDepthBins;
vDepths = [voPlot8Bins.middle];

% Make legend
for ii = 1:length(vDepths);
	csLegend{ii} = Str(vDepths(ii));
end

% bin x type x time
% bin x time x type (mean, lower, upper)
voHrfs = NumStruct(voHrfs);
% Destruct o
mY = reshape([voHrfs.mean], [], length(voHrfs));
for oHrf = voHrfs
	voHrfs(oHrf.iNum).upperBar = squeeze(oHrf.upper - oHrf.mean);
	voHrfs(oHrf.iNum).lowerBar = squeeze(oHrf.mean - oHrf.lower);
end

vAllDepths = [voDepthBins.middle];
Default oMap = ColorMapper(minmax(vAllDepths));
oMap.SetColorOrder(vDepths);

hAxis = gca; hold on
vc = 'rmbgy';
for ii = 1:length(voHrfs), voHrfs(ii).color = vc(ii); end;
% PlotWithError(voHrfs, vX, '', figure)
plot(vX, mY, 'linewidth', 2); hold on
%%
% 	set(gca, 'ColorOrder', mC1);
% plot(hAxis, vX, mY, 'linewidth', 2); hold on

% Colors

v = get(get(gcf, 'Children'), 'Children');
% v = get(hAxis, 'Children');
nC = length(v);
mC = zeros([nC,3]);

for iC = 1:nC
	mC(iC,:) = get(v(iC), 'Color'); 
end

mC = flipdim(mC,1);

viLine = [1 3 5];
nLines = size(mC,1);

for oHrf = voHrfs(viLine);
	viColor = mC(round(nLines*oHrf.iNum/oHrf.nTot),:);
	h = errorbar(vX,  oHrf.mean, oHrf.lowerBar, oHrf.upperBar, 'o', 'linewidth', 1, ...
		'MarkerEdgeColor', .9*viColor,'MarkerSize', 3, 'MarkerFaceColor', .9*viColor, ...
		'Color', viColor);
end
% colorbar; colormap jet
% viXLims = BoundingBox(vX);
FixFigLimits

vSize = GetSize(hAxis);
hLegend = legend(csLegend{:}, 'Location', 'BestOutside'); hold on;
SetSize(hAxis, vSize);

hAxisOut = hAxis;
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
