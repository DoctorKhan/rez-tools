function [nLength, iDim, nDims, viDim] = CoordInfo(mMat, nDims)

% CoordInfo;
%
%
%
% Khan 04/25/2012
 
%% Default params
Default nDims = 3

%% Initialize

%% Main
[nDims, iDim] = NumC(mMat, nDims);
nLength = NumP(mMat, nDims);

if nargout>3, viDim = size(mMat);end
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
