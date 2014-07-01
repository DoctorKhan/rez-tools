function [oMesh vSdf] = SurfTraject(oMesh, oRawiv, nIters, varargin)

% [oMesh vFinalSdf] = SurfTraject(oMesh, oRawiv, nIters, varargin);
%
%
%
% Khan 02/28/2012

%% Default
Default nIters = 80;

%% Initialize
Destruct(oRawiv); Destruct(oMesh)

nVerts = length(vertices);
vbStep = true(1, nVerts);

mPos0 = vertices;
vI1 = LinearInterp(oRawiv, oMesh);

nSkip = 10;
nDs = 30;
vDs = [ ones(1, nSkip) linspace(1,0.01, nDs)  0.01*ones(1, nIters-nSkip-nDs) ];
vSdf = nan(1, nVerts);
%%
Str('Iterating...')
tic
mPos1 = mPos0; mPos2 = mPos1;
for iIter = 1:nIters
%     ds = vDs(iIter);
    
    mPos1s = mPos1(:,vbStep);
    mNs = normals(:,vbStep);
    vI1s = vI1(vbStep);
        
    vbGood1 = all(isfinite(mPos2));
    
    % Evolve
    mCh = MatrixVectorProd(mNs, vI1s);
    mPos2(:,vbStep) = mPos1s - mCh; %#ok<*AGROW>
     
    vbGood2 = all(isfinite(mPos2));
    vbStep = vbStep & vbGood2;
    
    perPos2 = (frac(vbGood1) - frac(vbGood2))*100;
    if perPos2 > 0, Str(perPos2, '% Loss mPos2.'); end

    oMesh.vertices(:,vbStep) = mPos2(:,vbStep);
    [vSdf perLoss] = LinearInterp(oMesh, oRawiv);

    if perLoss > 0, Str(perLoss, '% loss in Sdf interp.'); end
    
    % Termination criterion
    s1b = frac(vbStep);
    vbStep = vbStep & (abs(vSdf) > 0.01);
    s2b = frac(vbStep);
    pls = (s1b - s2b)*100;
    Str(pls, '% landed this iteration.');
    
    % Update prev vars
    vI1 = vSdf; mPos1 = mPos2;
    
    perComp = frac(~vbStep);
    mss(vSdf);
    pf = fin(mPos2);
    TextWaitbar(perComp, Str('Completed:', perComp*nVerts, '/', nVerts, '.', pf, '% finite. Iteration', iIter));
    
    if perComp == 1, break; end
end
toc

%% Output
oMesh.distance = Mag(mPos1 - mPos0);
oMesh.vbGood = ~vbStep;
oMesh.sdf = vSdf;
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
