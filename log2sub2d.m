function [mCoords, viDim] = log2sub2d(mMatrix)

% [mCoords, viDim] = log2sub2d(mMatrix);
%
% Same as log2sub3d, but for 2d input
%
% Khan 10/18/2010

%% Default params


%% Initialize
viDim = size(mMatrix);

%% Main

mCoords = ind2sub2d(find(mMatrix(:)), viDim);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
