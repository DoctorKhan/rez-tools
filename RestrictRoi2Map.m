function oView = RestrictRoi2Map(oView, iROI, iMap, mapMin, mapMax)

% oView = RestrictRoi2Map(oView, iROI, iMap, mapMin, mapMax);
%
%
%
% Khan 01/24/2012
 
%% Default params
Default mapMin = -Inf & mapMax = Inf;

%% Initialize
Destruct oView
vMap = map{iMap};
oROI = ROIs(iROI);

%% Main
mGoodCoords = coords(:,vMap >= mapMin & vMap <= mapMax);

oROI.coords = intersectCols(oROI.coords, mGoodCoords);
oROI.name = Str(oROI.name, 'r', mapMin, 'to', mapMax);
oView = addROI(oView, oROI, 'select');

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
