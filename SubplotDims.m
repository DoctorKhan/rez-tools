function [nRows, nCols] = SubplotDims(nPlots)

%
% [nCols, nRows] = SubplotDims(nPlots);
%
% Compute optimal dimensions for subplot display of nPlots plots.
%
% Khan 09/30/09
%

vScreen = get(0, 'ScreenSize');
xyratio = vScreen(3)/vScreen(4); % e.g. 1920 / 1200

nCols = sqrt(xyratio*nPlots);
nRows = nCols/xyratio;

nCols = round(nCols);
nRows = round(nRows);

if nCols*nRows < nPlots, nCols = nCols+ 1; end

end
