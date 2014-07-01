% TestMeshGradNorm;
%
%
%
% Khan 03/18/2012

%% Default params

%% Initialize
sPre = 'Inter300s';
nSurfs = 16; iMaxSurf = nSurfs - 1;
%% Main
oMesh0 = RawMesh(sPre, 0);
oRawiv0 = RawMesh(sPre, 0);

oMesh = RawMesh(oMesh0);
oMesh.NormGrad(oRawiv, 'force');

SliceMeshOnVolume(oMesh, oRawiv0);
%%
% d = acos(Finite(dot(oMesh2.normals, oMesh.normals)));
% Str(mean(d), '+/-', std(d), 'degrees');

%%
NormBall(oMesh)
TestNormals(oMesh)

%% Note: type "doc hungarian" for variable prefix explanation.
