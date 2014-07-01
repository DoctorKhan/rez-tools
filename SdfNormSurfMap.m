function [tFinal, tGridded] = SdfNormSurfMap(sPre, nSurfs)

% tFinal = SdfNormSurfMap(sPre, nSurfs);
%
% Normalized distance map from SDF.
%
% Khan 04/21/2012
 
%% Default params


%% Initialize
mCoords = []; vValues = [];
iFinal = nSurfs - 1;
viSurfs = (1:nSurfs)-1;
%% Main
UpdateInterMeshes(sPre, nSurfs);

for iSurf = viSurfs
    oMesh = RawMesh(sPre, iSurf, nSurfs);
    mCoords = [mCoords oMesh.vertices];
    vValues = [vValues repmat(iSurf/iFinal, 1, length(oMesh.vertices))];
end

Str('Gridding...')
[tGridded, tbHoles] = DistGrid(mCoords, vValues, oMesh.tbDomain);

Str('Interpolating holes...');
tFinal = LaplaceMultiplier(tGridded, tbHoles);
Slide(tFinal);
figure; Hist(tFinal);


end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
