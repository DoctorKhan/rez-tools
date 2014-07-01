function oROI = RestrictROI2Layer1(oROI, oGrayView)

% RestrictROI2Layer1;
%
%
%
% Khan 09/25/2011

%% Default params


%% Initialize


%% Main

mLayer1 = GetLayerCoords(oGrayView, 1);
oROI.coords = intersectCols(mLayer1, oROI.coords);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
