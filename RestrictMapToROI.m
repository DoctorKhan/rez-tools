function oView = RestrictMapToROI(oView, sMapname, iROI)

% RestrictMapToROI;
%
% Only works in volume or gray so far.
%
% Khan 03/11/2010

%% Default params
if notDefined('oView'), oView = getSelectedView; end
if notDefined('sMapname'), sMapname = 'map'; end
% if notDefined('iIndex'), iIndex = length(oView.(sMapname)); end
if notDefined('iROI')
    oROI = getSelectedROI;
else
    if ischar(iROI), iROI = GetROINumber(iROI); end
    oROI = oView.ROIs(iROI);
end

%% Initialize
nMaps = length(oView.(sMapname));

%% Main
for iIndex = 1:nMaps
    vMap = oView.(sMapname){iIndex};
    
    vbBad = true(1, length(vMap));
    ivIntersect = nearpoints3d(oROI.coords, oView.coords);
    vbBad(ivIntersect) = false;
    vMap(vbBad) = NaN;
    cvMap{iIndex} = vMap;
end

oView = setParameterMap(oView, cvMap, [oView.mapName, ' restricted to ', oROI.name], oView.mapUnits);
oView = refreshScreen(oView);

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
