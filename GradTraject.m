function [tTraj vSdf] = GradTraject(oMesh, tW, nIters, vLimits, varargin)

% [tTraj vSdf] = GradTraject(oMesh, tW, nIters, vLimits, varargin);
%
%
%
% Khan 02/28/2012

%% Default
Default nIters = 40;
Default vLimits = [-1 2];
upperW = vLimits(2);
lowerW = vLimits(1);

%% Initialize
oMesh = RawMesh(oMesh);

Destruct(oMesh)

nVerts = length(vertices);
vbStep = true(1, nVerts);

%%
Str('Iterating...'); tic
mPos0 = vertices; % 3xnVerts position of mesh

mPos1 = mPos0;
mPos2 = mPos1;

vSdf = nan(1, nVerts);
tTraj = repmat(mPos0, [1 1 nIters+3]);

[gx, gy, gz] = Grad5p(tW, 'norm'); % gx = 300x300x300

% Inital position on mesh (3 x nVerts)
mDelta2 = [LinInterpC(gx, mPos1); LinInterpC(gy, mPos1); LinInterpC(gz, mPos1)];

ds = 0.5;
largeAngle = 70;
vbEvolve = vbStep;

for iIter = 1:nIters
    mPos1s = mPos1(:,vbStep);
    if total(vbStep) < 2, break; end
    vSdf(vbStep) = LinInterpC(tW, mPos1s);
    
    vbEvolve = vSdf < (upperW - .05) & vbEvolve;
    mPosEvo = mPos1(:,vbEvolve);
    mDelta2(:,vbEvolve) = normc([LinInterpC(gx, mPosEvo); LinInterpC(gy, mPosEvo); LinInterpC(gz, mPosEvo)]);
    
    if iIter > 1
        vAngle = acos(dot(mDelta1, mDelta2))*180/pi;
        vbLargeAngle = vAngle > largeAngle;
        w = largeAngle./vAngle(vbLargeAngle);
        mDelta2(:,vbLargeAngle) = HorzMat(w.*mDelta2(:,vbLargeAngle) + (1-w).*mDelta1(:,vbLargeAngle));
    end
    
    mPos2(:,vbStep) = mPos1s + ds*mDelta2(:,vbStep);
    tTraj(:,:,iIter) = mPos2; % tTraj = 3 x nPts x 1 xnIters
    
    vbGood2 = all(isfinite(mPos2));
    vbStep = vbStep & vbGood2;
    
    vSdf2 = LinInterpC(tW, mPos2);
    vbInc = vSdf2 > vSdf;
    mPos2(:,~vbInc) = mPos1(:,~vbInc);
    vbStep = vbStep & vbInc & (abs(vSdf) < upperW);
    
    % Update prev vars
    mPos1 = mPos2; mDelta1 = mDelta2;
    
    % Stats
    if mod(iIter,5) == 0
        mss(vSdf); pf = fin(mPos2);
        % Progress
        perComp = frac(~vbStep);
        TextWaitbar(perComp, Str('Completed:', perComp*nVerts, '/', nVerts, '.', pf, '% finite. Iteration', iIter));
        if perComp == 1, break; end
    end
end
TextWaitbar(1);
% 
% mPos1 = mPos0;
% mPos2 = mPos1;
% vbStep = true(1, nVerts);
% 
% % Negative trajectory
% for iIter = 1:2
%     mPos1s = mPos1(:,vbStep);
%     if total(vbStep) < 2, break; end
%     vSdf(vbStep) = LinInterpC(tW, mPos1s);
%     
%     vbEvolve = vSdf > (lowerW + 0.05) & vbEvolve;
%     mPosEvo = mPos1(:,vbEvolve);
%     mDelta2(:, vbEvolve) = normc([LinInterpC(gx, mPosEvo); LinInterpC(gy, mPosEvo); LinInterpC(gz, mPosEvo)]);
%     
%     % Reduce large angles
%     if iIter > 1
%         vAngle = acos(dot(mDelta1, mDelta2))*180/pi;
%         vbLargeAngle = vAngle > largeAngle;
%         w = largeAngle./vAngle(vbLargeAngle);
%         mDelta2(:,vbLargeAngle) = HorzMat(w.*mDelta2(:,vbLargeAngle) + (1-w).*mDelta1(:,vbLargeAngle));
%     end
%     
%     mPos2(:,vbStep) = mPos1s - ds*mDelta2(:,vbStep);
%     tTraj(:,:,3-iIter) = mPos2;
%     
%     vbGood2 = all(isfinite(mPos2));
%     vbStep = vbStep & vbGood2;
%     
%     vSdf2 = LinInterpC(tW, mPos2);
%     vbInc = vSdf2 < vSdf;
%     mPos2(:, ~vbInc) = mPos1(:, ~vbInc);
%     vbStep = vbStep & vbInc & (abs(vSdf) > lowerW);
%     
%     % Update prev vars
%     mPos1 = mPos2;
%     mDelta1 = mDelta2;
% end
toc
tTraj = squeeze(tTraj);
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
