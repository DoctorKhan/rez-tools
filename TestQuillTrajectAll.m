% Khan 03/19/2012
 
%% Default params
viSurfs = 6:7; nSurfs = max(viSurfs) + 1;
iFinal = viSurfs(end);
sPre = 'Inter300s';
cd /export/data/mri/Anatomy/GreeneHR/Cortex/Left/White-Pia
% Initialize
oMesh0 = RawMesh(sPre, 0, 8);
oMeshN = RawMesh(sPre, iFinal, 8);
% oMesh0.Truncate(1, 1, 60);
% Meshes
save r0
%%
load r0
%%
IsoMeshes(oRawiv0, oRawivN, 8, 0)
%%
for ii = 0:7
    
    oRawiv = Rawiv(sPre, ii);
    oMesh = RawMesh(sPre,ii);
    figure; SliceMeshOnVolume(oMesh, oRawiv);
    v = axis;
    c = mean(xlim);
    xlim((xlim - c)/1.5 + c);
    c = mean(ylim);
    ylim((ylim - c)/1.5 + c);
end
%%
UpdateInterMeshes(sPre, nSurfs);
%% Main
load r0
viSurfs = 6:7;
[oMesh cTraj] = QuillTrajectAll(sPre, viSurfs, oMesh0);
% save r1 oMesh
%%
oMeshFinal = GridMesh(oMesh);
save r2 oMesh oMeshFinal

[~, oMesh.ctbDomain] = Domains4DepthMap;
oMaps = InterpDepthMap(oMesh, oMeshFinal, oMesh0);
save r3 oMaps

%%
for ii = 1:8
    oMesh.tTraj(:,:,ii) = cTraj{ii};
end

%%
viDim = [300 300 300];
tTraj = oMesh.tTraj;
t = AccumMap(tTraj);
%%
tbDomain = oMesh.ctbDomain{2};
% [mCoords, vValues] = Traj2Depth(oMesh.tTraj, 5.4, tbDomain);

[tGridded, tbHoles] = DistGrid(mCoord, vValues, tbDomain);
t = LaplaceMultiplier(tGridded, tbHoles);
cent(t)
figure; Hist(t)

%% Note: type "doc hungarian" for variable prefix explanation.
