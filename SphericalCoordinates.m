function [tR tTheta tPhi vCenter] = SphericalCoordinates(iGridSize, vCenter)

% [tR vCenter] = SphericalCoordinates(iGridSize, vCenter);
%
%
%
% Khan 01/31/2012
 
%% Default params

%% Initialize
if is3d(iGridSize)
	viDims = size(iGridSize);
else
	viDims = repmat(iGridSize, 1, 3);
end

Default vCenter = (viDims - 1)/2 + 1;
if isscalar(vCenter), vCenter = repmat(vCenter, 1, 3); end

%% Main
[tX tY tZ] = meshgrid(1:viDims(1), 1:viDims(2), 1:viDims(3));
[tTheta, tPhi, tR] = cart2sph(tX, tY, tZ);

% tR = sqrt((tX - vCenter(1)).^2 + (tY - vCenter(2)).^2 + (tZ - vCenter(3)).^2);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
