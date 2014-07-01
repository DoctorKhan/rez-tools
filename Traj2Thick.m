function [mCoords, vValues] = Traj2Thick(mCoords, vDepth, tW, maxDepth)

% [mCoords, vValues] = Traj2Thick(tTraj, maxDepth, tbDomain);
%
%
%
% Khan 04/20/2012
 
%% Default params
Default maxDepth = Inf

%% Initialize
tTraj = double(tTraj);
viDim = size(tTraj);
mTraj = reshape(tTraj, 3, []); % 3 x (nPts*nSteps)
mW = LinearInterp(tW, mTraj); % nSteps x nPts

%% Main
mDelta = zeros(viDim(2:3));
mDelta(:,2:end) = squeeze(Mag(diff(tTraj,1,3)));
vAllValues = HorzVec(cumsum(mDelta,2));
mAllCoords = HorzMat(tTraj);

vbGood = abs(vAllValues) < maxDepth;

if defined('tbDomain')
    mDomain = log2sub3d(tbDomain);
    [~, viGood] = intersectCols(round(mAllCoords), mDomain);
    vbGood = vbGood & sub2log(viGood, vbGood);
end

vValues = vAllValues(vbGood);
mCoords = mAllCoords(:,vbGood);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
