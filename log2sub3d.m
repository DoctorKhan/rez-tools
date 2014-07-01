function [mCoords, viDim, x, y, z] = log2sub3d(tbMatrix)

% [mCoords, viDim] = log2sub3d(tbMatrix);
% 
% Convert logical tbMatrix to matlab subscript coordinates.
% 
% Khan 02/12/2010

%% Default params

%% Initialize
if ~islogical(tbMatrix)
    tbMatrix = isfinite(tbMatrix);
end

%% Main
viDim = size(tbMatrix);
mCoords = ind2sub3d(viDim, find(tbMatrix(:)));

x = VertVec(mCoords(1,:));
y = VertVec(mCoords(2,:));
z = VertVec(mCoords(3,:));


end %function