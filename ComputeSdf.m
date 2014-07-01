function ComputeSdf(oHemo, varargin)

% tFinal = ComputeSdf(sPre, nSurfs);
%
% Normalized distance map from SDF.
%
% Khan 04/21/2012

%% Default params
Default threshold = Inf;
Default tCurve
HemoInit

%% Initialize
Destruct oHemo

for oHemi = voHemis;
    for oTissue = voTissue;
        sFile = FileExt(oHemo, oHemi, oTissue, '.raw');
        pMesh = AnatPath(oHemo, oHemi, sFile);
        
        %% Initialize
%         if ischar(oMesh)
            assert(isFile(pMesh));
            oMesh = RawMesh(pMesh);
%         end
        
        % Compute Sdf
        oSdf = oMesh.SignedDistance;
        
        % Repair Sdf
        oSdf = FixSdf(oSdf);
        
        %% Main
        % Interp
        disp('Interpolating to common coordinate system... ');
        oSdf.InterpFull; cent(oSdf);
        oSdf.Save(FileExt(pMesh, 'Sdf.rawiv'));
    end
end

disp('completed.');

end % Function

% g = real(1./sqrt(1-tgDepth.^2));
% tgDepth = sqrt(tgNormx.*tgNormx + tgNormy.*tgNormy + tgNormz.*tgNormz);
% %% Gradient-based thickness
% [gx gy gz] = gradient(tDist);
% tgNormDepth = sqrt(gx.*gx + gy.*gy + gz.*gz);
% tGradThick = g./tgDepth;
% tGradThick(tGradThick>threshold) = nan;
% tGradThick(tGradThick<0) = nan;

%% Note: type "doc hungarian" for variable prefix explanation.
