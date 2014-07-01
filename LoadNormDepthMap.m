function [oView, oMaps] = LoadNormDepthMap(oView, oHemo)

% [oView, oMaps] = LoadNormDepthMap(oView, oHemo)
%
%
%
% Khan 12/30/2011

%% Default params
Default oView = InitHidden('Volume')
Default oHemo = HemoFromDir

%% Initialize

%% Main
pMap = SessionDir(oHemo, 'Volume', 'Timed', 'lamina.mat');

if isView(oView, 'Volume')
    oView = loadParameterMap(oView, pMap);
else
    oView = loadParameterMap(switch2Vol(oView), pMap);
    % 	oView = XformVol2Gray(oVolView, 'All');
end

%%
oView = setParameterMap(oView, oView.map, oView.mapName, oView.mapUnits, oView.mapAnnotation);

if nargout > 1
    csMaps = {'vNormMap', 'vPhysMap', 'vLegacy',  'vCurvMap', 'vThickMap', 'vbFinite'};
    cvMaps = oView.map;
    cvMaps(CellFun(@isempty, cvMaps)) = [];
    oMaps = cell2struct(VertVec(cvMaps(1:length(csMaps))), VertVec(csMaps));
end

% Make local link to file in global anatomy path
try
    oView = RefreshView(oView);
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
