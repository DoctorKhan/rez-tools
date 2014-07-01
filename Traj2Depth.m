function [mCoords, vDepth, vThick, mbGood] = Traj2Depth(tTrajAll, tW, maxDepth, oPial)

% [mCoords, vDepth, vThick, mbGood] = Traj2Depth(tTrajAll, tW, maxDepth, oPial);
%
%
%
% Khan 04/20/2012

%% Default params
Default maxDepth = Inf

%% Initialize
tic
tTrajAll = double(tTrajAll);
viDim = size(tTrajAll);
nSteps = viDim(3);
nAllTrajs = viDim(2);

%% Main
% Compute depths
vThick = nan(1, nAllTrajs);
nInc = 5000;
for iTraj0 = 1:nInc:nAllTrajs;
    
    viTraj = (iTraj0-1) + (1:nInc);
    viTraj(viTraj > nAllTrajs) = [];
    tTraj = tTrajAll(:,viTraj,:);
    
    mW = LinInterpC(tW, tTraj);
    [~, viLast] = min(abs(mW - 1), [], 2);
    viLast = HorzVec(viLast);
    
    nTrajs = length(viLast);
    mLastTrajPts = nan(3, nTrajs);
    
    for iDim = 1:3;
        mLastTrajPts(iDim,:) = diag(squeeze(tTraj(iDim, :, viLast)));
    end
    
    mPia = oPial.vertices;
    viPia = nearpoints3d(mLastTrajPts, mPia);
    mL = mLastTrajPts; % Coordinates of last point in each trajectory
    mM = mPia(:,viPia); % Coordinates of corresponding nearest pial mesh point
    
    
    mD = mM - mL;
    vL = Mag(mL);
    mProj = dot(mL, mD)./vL;
    
    vThick(viTraj) = (viLast-1)/2 + mProj;
    
    Thickness = vThick*.7;
    mss(Thickness, 1, 'mm');
    TextWaitbar(viTraj(end)/nAllTrajs);
end

% Expected trajectory depths
vDepth = (1:nSteps-1)/2;
mDepthExp = repmat(vDepth, [nAllTrajs, 1]);

tDelta = diff(tTrajAll, 1, 3);
mDepth = squeeze(Mag(tDelta)); clear tDelta
mDepth = cumsum(mDepth,2);

mbGoodDepth = isfinite(mDepthExp) & abs(mDepth - mDepthExp) < 0.02;

% Output
mDepth = mDepth - 1/2;

vbGoodThick = vThick > 0 & vThick < maxDepth;
mbGood = mbGoodDepth(vbGoodThick,:);
mDepth = mDepth(vbGoodThick,:);
vThick = vThick(vbGoodThick);
tCoords = tTrajAll(:,vbGoodThick,:);
[mDepth, mThick] = MixedMatch(mDepth, vThick);

% Output
vDepth = HorzVec(mDepth(mbGood));
vThick = HorzVec(mThick(mbGood));

mCoords = nan(3, total(mbGood));
for ii = 1:3
    mCoords(ii,:) = HorzVec(tCoords(ii,mbGood));
end

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.

%%    
% if defined('tbDomain')
%     mAllCoords = reshape(mAllCoords, 3, []);
%     v = LinInterpC(double(tbDomain), mAllCoords);
%     viCoords = coords2Indices(round(mAllCoords), size(tbDomain));
%     vbGood = tbDomain(viCoords);
% end
