function [tR vCenter] = RadialCoordinate(xDim, vCenter)

% [tR vCenter] = RadialCoordinate(iGridSize, vCenter);
%
%
%
% Khan 01/31/2012
 
%% Initialize
if is3d(xDim)
	viDim = size(xDim);
elseif isvector(xDim)
	viDim = repmat(xDim, 1, 3);
else
	viDim = xDim;
end

%% Default params
Default vCenter = (viDim - 1)/2 + 1;

if isscalar(vCenter)
	vCenter = repmat(vCenter, 1, 3); 
end

%% Main
for ii = 1:3
	cGrid{ii} = 1:viDim(ii);
end

[tX tY tZ] = meshgrid(cGrid{:});
tR = sqrt((tX - vCenter(1)).^2 + (tY - vCenter(2)).^2 + (tZ - vCenter(3)).^2);
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
