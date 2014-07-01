function [oMesh cTraj] = QuillTrajectAll(sPre, viAllSurfs, oMesh0, maxVal, varargin)

% [oMesh cTraj] = QuillTrajectAll(sPre, viAllSurfs, oMesh0, varargin);
%
%
%
% Khan 03/18/2012

%% Default params
Default sPre = "Inter300s"
Default oMesh0  = RawMesh(sPre, 0);
Default maxVal = 10
%% Initialize


if Option('reverse')
    viAllSurfs = fliplr(viAllSurfs);
end

viSurfs = viAllSurfs(2:end);

iFinal = viAllSurfs(end);
% iFirst = viAllSurfs(1);
nSurfs = length(viAllSurfs);

oRawiv0 = Rawiv(sPre, 0);
oRawiv0.tData(abs(oRawiv0.tData)>maxVal) = nan;
oRawivN = Rawiv(sPre, max(viAllSurfs));
oRawivN.tData(abs(oRawivN.tData)>maxVal) = nan;

oMesh = RawMesh(oMesh0);
if isempty(oMesh.normals)
    oMesh.NormSurf;
    oMesh.Save;
end

if Option('reverse')
    oMesh.vertices = oMesh.tTraj(:,:,oMesh.iSurf+2);
else
    oMesh.vertices = oMesh.tTraj(:,:,oMesh.iSurf);
end

cTraj{1} = oMesh0.vertices;

%% Main
oInterpVol = RawivInterp(oRawiv0, oRawivN, nSurfs);

viSurfs = viSurfs(find(oMesh.iSurf == viSurfs,1,'first'):end);

for iSurf = viSurfs
    try
        oRawiv = oInterpVol.Vol(iSurf);
        
        oMesh = QuillTraject(oMesh, oRawiv, '', iSurf, varargin{:});
        
        cTraj{iSurf+1} = oMesh.vertices;[oMesh cTraj] = QuillTrajectAll(sPre, viSurfs, oMesh0);

        
        if isequal(cTraj{1}, cTraj{2})
            keyboard
        end
        % Interp normals
        if iFinal ~= iSurf
            oMesh.NormInit(oInterpVol);
            oMesh.NormInterp;
        end
        figure; SliceMeshOnVolume(oMesh, oRawiv);
    catch oMe, oMe.stack(end), oMe.message, keyboard
    end
end

end
%% Note: type "doc hungarian" for variable prefix explanation.
