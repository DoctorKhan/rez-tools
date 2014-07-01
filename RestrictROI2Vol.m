function [oView, oROI] = RestrictROI2Vol(iROI, oView)

% oView = RestrictROI2Vol(iROI, oView);
%
% Restricts the ROI Coordinates to the Volume Coordinates.
%
% Khan 11/02/2010

%% Default params

%% Initialize
if isstruct(iROI)
	oView.ROIs(1) = iROI;
	iROI = 1;
end

mVolCoords = VertMat(VolumeCoords);
mROICoords = VertMat(oView.ROIs(iROI).coords);

%% Main
%Restrict ROI
oView.ROIs(iROI).coords = HorzMat(intersect(mROICoords, mVolCoords, 'rows'));
oROI = oView.ROIs(iROI);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
