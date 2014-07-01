% function TestSplitROIByMap

% TestSplitROIByMap;
%
%
%
% Khan 10/13/2011

%% Default params
if notDefined('oView')
	oView = InitHidden('Volume');
end


%% Initialize
HemoInit
voCurvBins = BinBounds(.08, .12, [ -.2 .2]);
oROI = Load('*V1pu50.mat', 'oROI');

%% Main
[oView, vBounds, vNumPtsSubROI] = SplitROIByMap(oView, oROI, voCurvBins, 'Curvature', '', 'save');

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
