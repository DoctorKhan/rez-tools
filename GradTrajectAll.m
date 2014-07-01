function [voMesh, oRawiv0, oRawiv1, mRadii] = GradTrajectAll(sPre, viSurfs, nIters, varargin)

% [voMesh, oRawiv0, oRawiv1] = GradTrajectAll(sPre, viSurfs, nIters, varargin);
%
%
%
% Khan 03/18/2012

%% Default params
Default sPre = "Inter300s"
Default viSurfs = 1:15

%% Initialize
iFinal = max(viSurfs); nSurfs = iFinal + 1;
mRadii = zeros(iFinal, 2);

oMesh0  = RawMesh(sPre, 0); oRawiv0 = Rawiv(sPre, 0);
oRawiv0.Align2Mesh(oMesh0, 'save');

oMesh1  = RawMesh(sPre, iFinal); oRawiv1 = Rawiv(sPre, iFinal);
oRawiv1.Align2Mesh(oMesh1, 'save');

voMesh = repmat(oMesh0, 1, nSurfs);

%% Main
w = 1;
oMesh = RawMesh(oMesh0);
for iSurf = viSurfs
    TextWaitbar(1-w, Str('Surface', iSurf, 'trajectories...'));
    Str('Surface', iSurf, 'trajectories...');
    w = 1-iSurf/15;
    oMesh.coef = w;
    
    oRawiv = w*oRawiv0 + (1-w)*oRawiv1;
    
    oMesh.NormGrad(oRawiv);
    oMesh = GradTraject(oMesh, oRawiv); fin(oMesh);
    voMesh(iSurf+1) = RawMesh(oMesh);
    
    vRadii = [ Radius(oMesh) Radius(oRawiv) ];
    mRadii(iSurf,:) = vRadii;
    Str('Surface', iSurf, 'radii (mesh, vol) =', vRadii, '.');

    TextWaitbar(1-w,  Str('Surface', iSurf, 'trajectories complete.'));
end

end
%% Note: type "doc hungarian" for variable prefix explanation.
