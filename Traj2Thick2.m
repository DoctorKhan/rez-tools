function [vThick, vbGoodTraj] = Traj2Thick2(tTrajIn, tW)

% vThick = Traj2Thick2(tTrajIn, tW);
%
% tTrajIn = 3 x nTraj x nSteps
%
% Khan 06/12/2012

%% Default params
%% Initialize
%% Main
tTrajPerm = permute(tTrajIn, [1 3 2]);
viDim = size(tTrajPerm);
nTrajs = viDim(3);

mTraj = reshape(tTrajPerm, 3, []); % 3 x (nPts*nSteps)
mW = reshape(LinearInterp(tW, mTraj), [], viDim(3)); % nSteps x nPts

vbGood = any(mW> 1) & sum(mW> 0 & mW< 1) > 2; % length = nPts
viGood = find(vbGood);

for iGoodPt = viGood(1:end)
    mCoords = tTrajPerm(:,:,iGoodPt);
    vWsteps = HorzVec(mW(:,iGoodPt)); % length = nSteps;
    iLast = find(vWsteps>1, 1, 'first');

    tTrajPerm(:,1:iLast,iGoodPt) = interp1(vWsteps(1:iLast), mCoords(:,1:iLast)', [0 vWsteps(2:iLast-1) 1])';
    for iDim = 1:3
        tTrajPerm(iDim,iLast+1:end, iGoodPt) = tTrajPerm(iDim,iLast,iGoodPt);
    end
    
    if mod(iGoodPt,20) == 0
        TextWaitbar(iGoodPt/nTrajs);
    end
end

tTrajGood = tTrajPerm(:,:,vbGood); % 3 x nSteps x nGoodPts
ds = diff(tTrajGood,1,2); % 3 x nGoodPts
vThick = squeeze(nansum(Mag(ds))); % length = nGoodPts
vbGoodThick =  vThick > 0.3 & vThick < 7;
vThick = vThick(vbGoodThick);

vbGoodTraj = vbGood;
vbGoodTraj(vbGood) = vbGoodThick; % length = nGoodThick

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
