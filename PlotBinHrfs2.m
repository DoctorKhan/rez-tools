function [hAxisOut hLegend] = PlotBinHrfs2(oROI, hAxis, voBins2Show)

% [hAxisOut hLegend] = PlotBinHrfs2(oROI, hAxis, voBins2Show);
%
%
%
% Khan 07/29/2011
%% Default params
HemoInit

Default voBins2Show = voPlot8Bins

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

%% Main
% Load results
[oMeanHRFs, voHrfs] = Load(oROI, 'oMeanHRFs', 'voHrfs');

oX.vX = oMeanHRFs(1).vX;

oX.label = 'Time (s)'; 

voY = NumStruct(voHrfs);
[voY.label] = 'Percent Modulation';
[voY.sType] = deal('depth');
sTitle = 'Profile';

% Make legend
% bin x type x time
% bin x time x type (mean, lower, upper)

vDepths    = [voPlot8Bins.middle];
vAllDepths = [voDepthBins.middle];

% oMap = ColorMapper(minmax(vAllDepths));
% oMap.SetColorOrder(vDepths);

PlotFillMulti(oX, voY, sTitle)

% plot(hAxis, vX, mY, 'linewidth', 2); hold on

% 	set(gca, 'ColorOrder', mC1);
% plot(hAxis, vX, mY, 'linewidth', 2); hold on

% Colors
v = get(hAxis, 'Children');
nC = length(v);
mC = zeros([nC,3]);

for iC = 1:nC
	mC(iC,:) = get(v(iC), 'Color'); 
end

mC = flipdim(mC,1);

iLine = 3;

% HemoInit
% vDepths = [voPlot8Bins.middle];

for oHrf = voHrfs(iLine);
	viColor = mC(oHrf.iNum,:);
	Destruct oHrf -> upperBar lowerBar
	middle = oHrf.mean;
	h = errorbar(vX,  middle, lowerBar, upperBar, 'o', 'linewidth', 1, ...
		'MarkerEdgeColor', .9*viColor,'MarkerSize', 3, 'MarkerFaceColor', .9*viColor, ...
		'Color', viColor);
end
% colorbar; colormap jet
viXLims = BoundingBox(vX);
xlim(viXLims);

vSize = GetSize(hAxis);
hLegend = legend(csLegend{:}, 'Location', 'BestOutside'); hold on;
SetSize(hAxis, vSize);

hAxisOut = hAxis;
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
