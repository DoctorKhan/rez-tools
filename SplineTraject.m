function [oMesh vSdf] = SplineTraject(oMesh, oW, nIters, t4g, varargin)

% [oMesh vFinalSdf] = SplineTraject(oMesh, oRawiv, nIters, varargin);
%
%
%
% Khan 02/28/2012

%% Default
Default nIters = 80;

%% Initialize
if isnumeric(oMesh)
    vertices = oMesh;
    clear oMesh
    oMesh.vertices = vertices;
end

oMesh = RawMesh(oMesh);
oW = Rawiv(oW);
tW = oW.tData;

Destruct(oMesh)

nVerts = length(vertices);
vbStep = true(1, nVerts);

mPos0 = vertices;
vSdf = nan(1, nVerts);
tPos = repmat(mPos0, [1 1 1 nIters+1]);
%%
Str('Iterating...')
tic
mPos1 = mPos0;
mPos2 = mPos1;

% Define gradient
Default t4g = SplineGrad(tW);
[gx, gy, gz] = Foliate(t4g);
g = sqrt(gx.^2 + gy.^2 + gz.^2);
gx = gx./g; gy = gy./g; gz = gz./g;

for iIter = 1:nIters
    % ds = vDs(iIter);
    
    mPos1s = mPos1(:,vbStep);
    
    vbGood1 = all(isfinite(mPos2));
    
    % Evolve
    mInterp = [...
        LinInterpC(gx, mPos1s);
        LinInterpC(gy, mPos1s);
        LinInterpC(gz, mPos1s)];
    
    %     dPos = normc(mInterp);
    mPos2(:,vbStep) = mPos1s - mInterp;
    
    tPos(:,:,:,iIter+1) = mPos2;
    
    vbGood2 = all(isfinite(mPos2));
    vbStep = vbStep & vbGood2;
    
    perPos2 = (frac(vbGood1) - frac(vbGood2))*100;
    if perPos2 > 0, Str(perPos2, '% Loss mPos2.'); end
    
    [vSdf perLoss] = LinInterpC(tW, mPos2);
    if perLoss > 0, Str(perLoss, '% loss in Sdf interp.'); end
    
    % Termination criterion
    s1b = frac(vbStep);
    vbStep = vbStep & (abs(vSdf) < 1);
    
    s2b = frac(vbStep);
    pls = (s1b - s2b)*100;
    
    Str(pls, '% landed this iteration.');
    
    % Update prev vars
    mPos1 = mPos2;
    
    % Stats
    perComp = frac(~vbStep);
    mss(vSdf);
    pf = fin(mPos2);
    
    TextWaitbar(perComp, Str('Completed:', perComp*nVerts, '/', nVerts, '.', pf, '% finite. Iteration', iIter));
    
    if perComp == 1, break; end
end
toc

%% Output
oMesh.distance = tPos(:,:,:,1:iIter+1);
oMesh.vbGood = ~vbStep;
oMesh.sdf = vSdf;
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
