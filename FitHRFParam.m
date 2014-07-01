function [vXRes, vResiduals] = FitHRFParam(vX, mParams, iOrder, sFitColor, sStyle)

% [vXRes, vResiduals] = FitHRFParam(vX, mParams, iOrder);
%
%
%
% Khan 05/12/2010

%% Default params
if notDefined('sFitColor'), sFitColor = ''; end
if notDefined('sStyle'), sStyle = '-'; end
%% Initialize


%% Main
ovParamStats = CalcStats(mParams, 0.68);

vY = ovParamStats.mean;
vU = ovParamStats.upper;
vL = ovParamStats.lower;

mY = mParams;
mX = repmat(vX, rows(mY), 1);

% Remove nans
vmBad = isnan(mY);
mX(vmBad) = [];
mY(vmBad) = [];

% Fit
vPolyFitParams = polyfit(mX(:), mY(:), iOrder);

vXFitPlot = linspace(min(vX), max(vX), 100);
vYFitPlot = polyval(vPolyFitParams, vXFitPlot);

vYFit = polyval(vPolyFitParams, mX(:));
vResiduals = mY(:) - vYFit;
vXRes = mX(:);

barwidth = 0.03;

% Create Basic Plot
FitPlot(vX, vY, vL, vU, vXFitPlot, vYFitPlot, barwidth, sFitColor, sStyle)

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
