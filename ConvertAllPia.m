function ConvertAllPia(voHemo)
%
%
%
% Khan 07/08/2011

%% Default params
HemoInit

%% Main
for oHemo = voHemo
    Destruct oHemo
    sTissue = 'Pia';
    for oHemi = voHemis, sHemi = oHemi.sHemi;
        oSeg  = Seg(oHemo, sHemi);
        oMesh = RawMesh(Surf2VistaFile(oHemo, sHemi, sTissue));
        oMesh = oMesh.Align2Vol(oSeg.Pia);       
        
        pSave = AnatPath(oHemo, sHemi, [sSubject, sHemi, sTissue]);
        oMesh.Save(FileExt(pSave, '.mat'));
        oMesh.Save(FileExt(pSave, '.raw'));        
    end
    CombMeshHemis(oHemo, sTissue);
end

%% Note: type "doc hungarian" for variable prefix explanation.
