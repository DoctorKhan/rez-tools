function [mCoords, vData, viDim] = mat2sub3d(tData)

% [mCoords, vData, viDim] = mat2sub3d(tData);
%
%
%
% Khan 06/09/2012
 
%% Default params


%% Initialize


%% Main
tbFin = isfinite(tData);
[mCoords, viDim] = log2sub3d(tbFin);
vData = tData(tbFin);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
