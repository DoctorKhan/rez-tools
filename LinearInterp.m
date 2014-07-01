function [ vInt, percentLoss ] = LinearInterp(oVol, oMesh, varargin)

% [ vOut, percentLoss ] = LinearInterp(oMesh, oVol, varargin);
%
%
%
% Khan 04/01/2012

%% Arg handling

if isMesh(oVol) || isRawiv(oMesh)
        [oMesh oVol] = swap(oMesh, oVol);
end

if islogical(oVol)
    oVol = double(oVol) - 0.5;
end

if isnumeric(oVol)
    tData = oVol;
else
    tData = oVol.tData;
    mBox = oVol.mBox;
    vScale = oVol.vScale;
end

if isnumeric(oMesh)
    mCoords = HorzMat(oMesh);
elseif islogical(oMesh)
    mCoords = log2sub3d(oMesh);
else
    if Option('normals')
        mCoords = oMesh.vertices + oMesh.normals;
    else
        mCoords = oMesh.vertices;
    end
end

mCoords = HorzMat(mCoords);

%% Default params
Default vScale = [1 1 1]
if notDefined('mBox')
    mBox = [1 1 1; size(tData)];
end

%% Initialize
mCoordsTarg = Box2Sub(mCoords, mBox, vScale);

%% Main
[vInt vGood] = LinInterpC(tData, mCoordsTarg);

%% Output
percentLoss = fin(tData) - fin(vGood);
if percentLoss > 0, Str(percentLoss, '% data loss in interpolation.'); end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
