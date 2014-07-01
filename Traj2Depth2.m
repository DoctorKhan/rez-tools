function [mCoords, mDepth, vThick, vbGood] = Traj2Depth2(tTraj, tW, maxDepth, tbDomain)

% [mCoords, vDepths] = Traj2Depth2(tTraj, maxDepth, tbDomain);
%
%
%
% Khan 04/20/2012
 
%% Default params
Default maxDepth = Inf

%% Initialize
tic
tTraj = double(tTraj);
viDim = size(tTraj);
nSteps = viDim(3);

%% Main
% Interpolate W values to trajs
mAllCoords = HorzMat(tTraj);
tic; vW = LinInterpC(tW, mAllCoords); toc
mWmap = reshape(vW, [], nSteps); clear vW
vbFull = any(mWmap > 1,2) & any(mWmap < 0,2);

% Compute depths
tDelta = diff(tTraj,1,3); % Change between steps, x,y,z
clear tTraj
mDelta = Mag(tDelta); % nTrajs x nSteps, mag
clear tDelta
mAllDepths = cumsum(mDelta,2);
mAllDepths(:,end+1) = 0;
mAllDepths = circshift(mAllDepths, [0 1]);

vbShort = ~any(mWmap < 1 & mAllDepths > maxDepth,2);
viFullTrajs = HorzVec(find(vbFull & vbShort));
nGoodTrajs = length(viFullTrajs);

%%
vThick = nan(1, nGoodTrajs);

mbFin = isfinite(mWmap) & isfinite(mAllDepths);
mbInc = diff(mWmap,1,2) > 0;
mbInc(:,end+1) = false;

mbGood = mbFin & mbInc;

mDepth = nan(nGoodTrajs, nSteps);
mX = mWmap(viFullTrajs,:);
mY = mAllDepths(viFullTrajs,:);

for iTraj = 1:length(viFullTrajs)
    vX = mX(iTraj, :);
    vY = mY(iTraj, :);

    vbGood = mbGood(viFullTrajs(iTraj),:);
    try
    vEnds = interp1(vX(vbGood), vY(vbGood), [0 1]);
    mDepth(iTraj,vbGood)   = vY(vbGood) - vEnds(1);
    vThick(iTraj) = diff(vEnds);    
    TextWaitbar(iTraj/nGoodTrajs);
end
TextWaitbar(1);

mCoords = mAllCoords(:,viFullTrajs,:);

vbGood = vThick < maxDepth & isfinite(vThick) & HorzVec(all(isfinite(mDepth),2)) & HorzVec(all(isfinite(mCoords)));
vThick = vThick(vbGood); mDepth = mDepth(vbGood,:); mCoords = mCoords(:,vbGood);
% vDepths = HorzVec(mDepth);
toc
%%
%     mbGood = abs(mAllDepths) < maxDepth;
% vbGood = HorzVec(mbGood);
% 
%     
%     iLast = find(vbNeg(iTraj,:), 1,'first');
%     if isempty(iLast), iLast = nSteps; end
%     
%     
%     if any(diff(vX) <=0)
%         keyboard
%     end
%     
%     vThick(iTraj) = interp1(vX, vY, 1);
%     vZero(iTraj) = interp1(vX, vY, 0);
% 
% mbGood = abs(mAllDepths) < maxDepth;
% vbGood = HorzVec(mbGood);


end % Function

% toc

%%
% nGoodTrajs = size(mWmap, 1);
% vThick = nan(1, nGoodTrajs);
% vZero = nan(1,nGoodTrajs);
% 
% mDw = diff(mWmap, 1, 2);
% vbNeg = ~(mDw>0 & isfinite(mDw));
 


% 
% if defined('tbDomain')
%     mAllCoords = reshape(mAllCoords, 3, []);
%     v = LinInterpC(double(tbDomain), mAllCoords);
%     viCoords = coords2Indices(round(mAllCoords), size(tbDomain));
%     vbGood = tbDomain(viCoords);
% end
% 
% mDepth = mAllDepths(vbGood,:);
% mCoords = mAllCoords(:,vbGood);

%% Note: type "doc hungarian" for variable prefix explanation.
