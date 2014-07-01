function PlotFillMulti(oX, voY, sTitle, varargin)

% PlotFillMulti(oX, voY);
%
%
%
% Khan 01/07/2012

%% Default params


%% Initialize
voY = NumStruct(voY);

% if strcmpi(voY(1).label, 'FWHM')
	[voY.bLongLegend] = deal(true);
% end

%% Main
% Plot
for oY = voY
	PlotFill(oX, oY); 
	hold on
end

if isfield(oX, 'label')
	xlabel(oX.label);
end

if isfield(oY, 'label')
	ylabel(oY.label);
end

if defined('sTitle')
	title(sTitle);
end

% Set legend
if regexpi(oY.label, 'fwhm')
	sLoc = 'NorthEastOutside';
else
	sLoc = 'Best';
end

legend('Location', sLoc);

hold off
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
