% Khan 03/18/2012

% cd /export/data/mri/Anatomy/GreeneHR/Cortex/Left/White-Pia

%% Default params

% Initialize

% Main
oMesh = RawMesh(oMesh0);
% Subset select
oMesh.Truncate(1, 1, 70);


%

% oRawiv0 = oRawiv0.InterpFull;
% oRawiv1 = oRawiv1.InterpFull;

% oRawiv0.Align2Mesh(oMesh0, 'save');
% oRawiv1.Align2Mesh(oMesh1, 'save');

% Meshes
% [oMesh, oRawiv0, oRawiv1] = IsoMeshes(oRawiv0, oRawiv1, nSurfs);

%% Evolve
Default sPre = "Inter300s"
Default viSurfs = 0:7
iFinal = max(viSurfs);
nSurfs = iFinal + 1;

oMesh0  = RawMesh(sPre, 0);
oRawiv0 = Rawiv(sPre, 0);
oMeshN  = RawMesh(sPre, iFinal);
oRawivN = Rawiv(sPre, iFinal);
oVolInt = RawivInterp(oRawiv0, oRawivN, nSurfs);
oMesh.iSurf = 6;
oRawiv = oVolInt.Vol(oMesh.iSurf);
oMesh.NormInit(oVolInt);
oMesh.NormInterp;

oMesh = QuillTraject(oMesh, oRawiv); fin(oMesh);
SliceMeshOnVolume(oMesh, oRawiv);
%%


%%
% Interp normals
if iSurf < iFinal
    oMesh.NormInit(oVolInt);
    oMesh.NormInterp;
end



%% Note: type "doc hungarian" for variable prefix explanation.
