function [m s vOrigin] = Radius(mCoords, vOrigin)

% [m s vOrigin] = Radius(mCoords);
%
%
%
% Khan 03/15/2012
 
%% Arg Handling
if isRawiv(mCoords)
    oRawiv = mCoords;
    vb = abs(oRawiv.tData)<.5;
    mCoords = oRawiv.mCoords(:,vb(:));
end

oMesh = RawMesh(mCoords);

%% Initialize
mCoords = HorzMat(oMesh.vertices);
mCoords = mCoords(:,all(isfinite(mCoords)));
Default vOrigin = median(mCoords,2);

%% Main
r = Mag(MatrixVectorDiff(mCoords,vOrigin));
[m s] = mss(r);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
