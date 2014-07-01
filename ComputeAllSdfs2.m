function ComputeAllSdfs2(voHemo, iRefine)

% ComputeAllSdfs2;
%
%
%
% Khan 05/01/2012
 
%% Default params
Default iRefine = 0;

%% Initialize
HemoInit

%% Main
for oHemo = voHemo
    for oHemi = voHemis
        Destruct oHemo;
        Destruct oHemi;

        oHemo.sHemi = oHemi.sHemi;
        [oWhite, oPia] = GetMesh(oHemo);
        
        pSeg = AnatPath(oHemo, [sSubject, sHemi]);
        
        pWhiteSdf = FileExt(pSeg, 'WhiteSdf.rawiv');
        oWhiteSdf = oWhite.SignedDistance;
        oWhiteSdf.Save(pWhiteSdf);
%         FixSdf(pWhiteSdf);
                
        pPiaSdf = FileExt(pSeg, 'PiaSdf.rawiv');
        oPiaSdf = oPia.SignedDistance;
        oPiaSdf.Save(pPiaSdf);
        FixSdf(pPiaSdf);
    end
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
