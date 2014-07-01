% function AlignAll

% AlignAll;
%
%
%
% Khan 04/23/2012

% Default params
HemoInit

% Initialize
oHemi = voHemis(2);
oHemo = oKhan;

% Main
oSegVol = Seg(St(oHemo, oHemi, '.Class'));
%
pWhiteMsh = St(oHemo, oHemi, 'White.raw');
if isFile(pWhiteMsh)
    oWhiteMesh = RawMesh(pWhiteMsh);
else
    oWhiteMesh = oSegVol.Mesh(5);
    tWhite = DilationMap(oSegVol.White.tData);
    oWhiteMesh.Align2Vol(tWhite);
    SliceMeshOnVolume(oWhiteMesh, oSegVol.White.tData,2);
    oWhiteMesh.Save(pWhiteMsh);
    
    %% Sdf
    oWhiteSdf = oWhiteMesh.SignedDistance;
    oWhiteSdf.Save;
end
%%
pPialSdf = St(oHemo, oHemi, 'PiaSdf.rawiv');

pPia = St(oHemo, oHemi, 'Pia.raw');
if isFile(pPia)
    oPialMesh = RawMesh(pPia);
else
    oPialMesh = ReadFreeSurf('rh.pial', .7);
    oPialMesh.Save(pPia);
    
    tPia = DilationMap(oSegVol.Pia.tData);
    oPialMesh.Align2Vol(tPia);
    SliceMeshOnVolume(oPialMesh, oSegVol.Pia.tData,2);
    
    oPialMesh.Save
    
    % Sdf volumes
    
    oPialSdf = oPialMesh.SignedDistance;
    oPialSdf.Align2Mesh(oPialMesh); % Required  -[1 1 1] adjustment.
    SliceMeshOnVolume(oPialMesh, oPialSdf,2);
    oPialSdf.Save;
end

if isFile(pPialSdf)
    oPialSdf = Rawiv(pPialSdf);
else
    oPialSdf = oPialMesh.SignedDistance;
    oPialSdf.Align2Mesh(oPialMesh); % Required  -[1 1 1] adjustment.
    SliceMeshOnVolume(oPialMesh, oPialSdf,2);
    oPialSdf.Save;
end
%% Maps
oMaps = NormSdf(oWhiteSdf, oPialSdf, 'save');

%% Note: type "doc hungarian" for variable prefix explanation.
