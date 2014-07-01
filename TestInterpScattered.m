% function TestInterpScattered

% TestInterpScattered;
%
%
%
% Khan 04/14/2012
cd /export/data/mri/Anatomy/GreeneHR/Cortex/Left/White-Pia

% Default params
Default sPre = "Inter300s"
Default viSurfs = 1:15

% Initialize
iFinal = max(viSurfs);

oMesh0  = RawMesh(sPre, 0);
oRawiv0 = Rawiv(sPre, 0);
oRawiv1 = Rawiv(sPre, iFinal);

%% Main
oMesh = RawMesh(oMesh0);

iSurf = 1; w = 1-iSurf/15;
oMesh.coef = w; oMesh.iNum = iSurf;
oRawiv = w*oRawiv0 + (1-w)*oRawiv1;

[oMesh oQuill] = QuillTraject(oMesh, oRawiv);
[oMesh  vDist] = QuillInterp(oMesh, oQuill);

%%
iSurf = 2; w = 1-iSurf/15;
oMesh.coef = w; oMesh.iNum = iSurf;
oRawiv = w*oRawiv0 + (1-w)*oRawiv1;

oMeshS2 = oRawiv.Mesh;
oMeshS2.Refine(1);

%%
[oMesh oQuill] = QuillTraject(oMesh, oRawiv);
[oMesh  vDist] = QuillInterp(oMesh, oQuill);

Destruct oRawiv;
%%
mVerts =  [oMesh0.vertices oMeshS2.vertices];
mValues = [oMesh0.normals   oMeshS2.normals];

mBox = BoundingBox(mVerts);
vbIn = true(1, length(mCoords));
for ii = 1:3
    vbIn = mCoords(ii,:) > mBox(1,ii) & mCoords(ii,:) < mBox(2,ii) & vbIn;
end
mIn = mCoords(:, vbIn);

oTri = InterpScattered(mVerts, mValues);
oT.normals = oTri.Eval(mCoords); clear oTri
%%
[oT.normals vbFin] = Finite(oT.normals);
oT.vertices = mCoords(:,vbFin);

SliceMeshOnVolume(oT, oRawiv);

%%

[oMesh oQuill] = QuillTraject(oMeshS1, oRawiv); fin(oT);
[oMesh  vDist] = QuillInterp(oT, oQuill);


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

 
%% Note: type "doc hungarian" for variable prefix explanation.
