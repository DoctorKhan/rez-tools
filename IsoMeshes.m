function [oMesh, oRawiv0, oRawivN] = IsoMeshes(oRawiv0, oRawivN, oMesh0, oMeshN, nSurfs, iRefine)

% [oMesh, oRawiv0, oRawivN] = IsoMeshes(oRawiv0, oRawivN, nSurfs, iRefine);
%
%
%
% Khan 03/16/2012

%% Default params
sPre = 'Inter300s';
Default oRawiv0 = Rawiv(sPre, 0);

Default nSurfs = 8 & iRefine = 0;
iFinal  = nSurfs - 1; iPenult = iFinal - 1;
Default oRawivN = Rawiv(sPre, iFinal);

oRawiv0 = Rawiv(oRawiv0);
oRawivN = Rawiv(oRawivN);

%%
oMesh0 = RawMesh(sPre, 0);
tDomain = oMesh0.Domain;
oMesh0.Align2Vol(tDomain);
oMesh0.NormSurf(oRawiv0);
oMesh0.Save;
%%
SliceMeshOnVolume(oMesh0, tDomain); 
xlabel('mesh to segmentation alignment');
%%
oRawiv0.Align2Mesh(oMesh0);
oRawiv0.Save;

oMeshN = RawMesh(sPre,iFinal);
oMeshN.Align2Vol(tDomain);
oMeshN.NormSurf(oRawivN);
oMeshN.Save;

oRawivN.Align2Mesh(oMeshN);
oRawivN.Save;

%% Main
oInterpVol = RawivInterp(oRawiv0, oRawivN, nSurfs);
for iSurf = 1:iPenult
    oRawiv = oInterpVol.Vol(iSurf);
    
    oMesh = oRawiv.Mesh;
    oMesh.Save;
    
%     figure; SliceMeshOnVolume(oMesh, oRawiv);
    
    c = mean(xlim);
    xlim((xlim - c)/1.1 + c);
    c = mean(ylim);
    ylim((ylim - c)/1.1 + c);
    TextWaitbar(iSurf/iPenult, 'creating intermediate meshes');
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
