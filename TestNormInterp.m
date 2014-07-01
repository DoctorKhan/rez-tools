% Khan 04/14/2012

cd /export/data/mri/Anatomy/GreeneHR/Cortex/Left/White-Pia

% Default params
Default sPre = "Inter300s"
Default viSurfs = 1:15

% Initialize
iFinal = max(viSurfs);
nSurfs = iFinal + 1;

oMesh0  = RawMesh(sPre, 0);
oMesh = RawMesh(oMesh0);
oRawiv0 = Rawiv(sPre, 0);
oRawiv1 = Rawiv(sPre, iFinal); % oRawiv1.Align2Mesh(oMesh1, 'save');

%%
oMesh.iSurf = iSurf; oMesh.iMaxSurf = iFinal;
SdfInterp = @(iSurf) (1-iSurf/iFinal)*oRawiv0 + (iSurf/iFinal)*oRawiv1;

oMesh.NormSurf;         voMesh(1) = oMesh;
oRawiv = SdfInterp(1);  oMesh = oRawiv.Mesh;
oMesh.NormSurf;         voMesh(2) = oMesh;
oRawiv = SdfInterp(2);  oMesh = oRawiv.Mesh;
oMesh.NormSurf;         voMesh(3) = oMesh;



%%
oMesh.vbSubset = oMesh.vertices(1,:) <= 60;
oMesh.vertices = oMesh.vertices(:,oMesh.vbSubset);
oMesh.normals = oMesh.normals(:,oMesh.vbSubset);

oMeshPre = RawMesh(oMesh);
[oMesh oQuill] = QuillTraject(oMesh, oRawiv); fin(oMesh);

[oMesh vDist] = QuillInterp(oMesh, oQuill);

o.mDist(:,iSurf+1) = vDist(:);

mss(vDist);

%% S2
iSurf = 2; w = 1-iSurf/15;
oMesh.coef = w; oMesh.iNum = iSurf;
oRawiv = w*oRawiv0 + (1-w)*oRawiv1;

%%oNorm = RawMesh(sPre, iSurf);
% ivTrajPt2MeshPt = nearpoints3d(oMesh.vertices, oNorm.vertices);
%%
oMesh = meshRefine(oMesh, 0);
SliceMeshOnVolume(oMesh, oRawiv1, 1, 45);
%%
oMesh = GridNormals(oMesh, oNorm);
% oMesh.normals = oNorm.normals(:,ivTrajPt2MeshPt);

[oMesh oQuill] = QuillTraject(oMesh, oRawiv); fin(oMesh);
[oMesh  vDist] = QuillInterp(oMesh, oQuill);

o.mDist(:,iSurf+1) = vDist(:);

mss(vDist);

%% Note: type "doc hungarian" for variable prefix explanation.
