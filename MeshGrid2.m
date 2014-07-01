function [mX mY mZ mCoords vX vY vZ] = MeshGrid2(xDim, vScale, varargin)

% [mX mY mZ mCoords vX vY vZ] = MeshGrid2(xDim, vScale, varargin);
%
%
%
% Khan 04/03/2012

%% Default params
if isscalar(xDim)
    viDim = repmat(xDim, 1, 3);
elseif isequal(size(xDim), [2 3]) && defined('vScale');
    viDim = diff(xDim)./vScale + 1;
elseif ndims(xDim) > 2
    viDim = size(xDim);
else
    viDim = xDim;
end

Default mBox(1,:) = [1 1 1];
Default vScale = [1 1 1];
%% Initialize
if ischar(mBox(1,:)), varargin = [mBox(1,:) varargin]; end
if ischar(mBox(1,:)), vScale = [vScale varargin]; end

%% Main
vX = 1:viDim(1); vY = 1:viDim(2); vZ = 1:viDim(3);

vX = (vX-1)*vScale(1) + mBox(1,1);
vY = (vY-1)*vScale(2) + mBox(1,2);
vZ = (vZ-1)*vScale(3) + mBox(1,3);

[mY mX mZ] = meshgrid(vY,vX,vZ);

if Option('classic')
    [mX mY] = swap(mX, mY);
end

mCoords = nan(3, prod(viDim));
mCoords(1,:) = mX(:);
mCoords(2,:) = mY(:);
mCoords(3,:) = mZ(:);

if nargout < 2
    mX = mCoords;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
