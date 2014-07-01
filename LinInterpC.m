function [vOut vGood vbGood] = LinInterpC(tData, mCoords, badVal)

% [vOut vGood vbGood] = LinInterpC(tData, mCoords, badVal);
%
%
%
% Khan 04/10/2012
 
%% Default params
Default badVal = Inf;

%% Initialize
if islogical(mCoords)
    mCoords = log2sub3d(mCoords);
end

mCoords = double(mCoords);
if ndims(mCoords) > 2
    viSize = size(mCoords);
    mCoords = reshape(mCoords, 3,[]);
end

tData = double(tData);
[mFin, ~, vbGood] = Finite(mCoords);
vOut = badVal*ones(1,len3(mCoords));
%% Main
tData = permute(tData, [2 1 3]);

% viDim = size(tData); viDimXY = viDim(1:end-1); iDimZ = viDim(end);
% vInt = myCinterp3(tData, viDimXY, iDimZ, mFin, badVal);

[x, y, z] = Foliate(mFin);
vGood = mirt3D_mexinterp(tData, x, y, z);
vOut(vbGood) = vGood;

if exist('viSize', 'var')
    vOut = reshape(vOut, viSize(2:end));
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
