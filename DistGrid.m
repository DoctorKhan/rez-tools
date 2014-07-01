function [tVol, oIntermediate] = DistGrid(mCoords1x, vValues, tbDom1x, viGridSpacing, nSamples)

% [tVol, oIntermediate] = DistGrid(mCoords1x, vValues, tbDom1x, viGridSpacing, nSamples);
%
%
% Khan 04/19/2012

%% Default params
nIters = 10;
Default viGridSpacing = [1 1 1 2 2 2 3 3 5 5];
viGridSpacing = repmat(viGridSpacing, 1, nIters);

%% Initializes
% Set orientation
mCoords1x = HorzMat(mCoords1x);
vValues = HorzVec(vValues);

% Select finite
vbFin = all(isfinite(mCoords1x)) & isfinite(vValues);
mCoords1x = mCoords1x(:,vbFin);
vValues = vValues(vbFin);

% Select by number of samples
nPts = length(vValues);
if defined('nSamples')
    viResamp = randsample(nPts, nSamples);
    mCoords1x  = mCoords1x(:, viResamp);
    vValues  = vValues(:, viResamp);
end

% Set domain
if notDefined('tbDom1x')
    viDim1x = GetDimFromAnat;
    tbDom1x = true(viDim1x);
else
    viDim1x = size(tbDom1x);
end


if isscalar(tbDom1x), tbDom1x = repmat(tbDom1x, 1, 3); end
if numel(tbDom1x) == 3, tbDom1x = true(tbDom1x); end

% Subvolume 1x
[mBoxSub1x, viDimSub1x] = SubVol(tbDom1x);

% Upsample to 2x
mCoords2x = 2*mCoords1x;
mBoxSub2x = 2*mBoxSub1x;
tbDom2x = Resize3(tbDom1x, 2);
tbHoles2x = tbDom2x;

% Subvolume 2x
[tbHolesSub2x, viLowerSub2x, viDimSub2x] = SubVol(tbHoles2x, mBoxSub2x, 'tSub');
mTrajCoordsSub2x = mCoords2x - viLowerSub2x + 1;
nHoles2x = total(tbHolesSub2x);
tSub2x = nan(viDimSub2x);

%% Main
for iGridSpacing = viGridSpacing
    sprintf(Str('Grid spacing:', iGridSpacing)); % Sample rate
    
    
    mTrajDown0 = round(mTrajCoordsSub2x/iGridSpacing)*iGridSpacing;
    nPts = length(mTrajDown0);
    nMaxShift = round((iGridSpacing-1)/2);
    viShift = randi([0 nMaxShift], [1 nPts]);
    viDir = randi(26, [1 nPts]);
    
    miDir = CubePts(viDir);
    try
    miDisp = miDir.*viShift;
    catch, keyboard; 
    end
    
    mTrajDown = mTrajDown0 + miDisp;
    mTrajDown = EnforceBounds(mTrajDown, viDimSub2x);
    viTraj    = coords2Indices(mTrajDown, viDimSub2x);
    
    % Holes
    vbHoles = tbHolesSub2x(viTraj);
    
    % Restrict grid centers to holes
    mDownHole = mTrajDown(:,vbHoles);
    vValHoles = vValues(vbHoles);
    
    % Restrict coordiates to iGridSpacing diameter of grid center
    mTrajHole = mTrajCoordsSub2x(:,vbHoles);
    
    % Weights
    gridRadius = iGridSpacing*sqrt(2)/2;
    
    vWeights = VertVec(gridRadius - Mag(mDownHole - mTrajHole));
    vWeights(vWeights < 0) = 0;
    
    % Norm factor (density correction)
    tNorm = accumarray(mDownHole', vWeights, viDimSub2x, @sum);
    
    viGridInd = coords2Indices(mDownHole, viDimSub2x);
    vNorm = HorzVec(tNorm(viGridInd));
    vNormWts = vWeights./vNorm; % Normalized weights
    
    % Sum the moments
    vMoments = VertVec(vNormWts.*vValHoles); % Compute moments   
    tAccum = accumarray(mDownHole', vMoments, viDimSub2x, @sum, nan);
    
    tSub2x(tbHolesSub2x) = tAccum(tbHolesSub2x);
    
    % Identify hole
    tbFailed = tbHolesSub2x & ~isfinite(tSub2x);
    
    if total(tbFailed) == 0, break; end
    nHoles = total(tbFailed);
    
    progFrac = 1-nHoles/nHoles2x;
    tbHolesSub2x = tbFailed; 
    TextWaitbar(progFrac);
end

% cent(tSub2x); title('Gridded');

%% Repair
% Linearly interpolate holes
tbHolesSub2x = tbHolesSub2x & ~isfinite(tSub2x);
vInterped = LinInterpC(tSub2x, tbHolesSub2x);

tbClosed = tbHolesSub2x;
tbClosed(tbHolesSub2x) = isfinite(vInterped);

tLin = tSub2x;
tLin(tbClosed) = vInterped(isfinite(vInterped));
% cent(tLin); title('Linear interpolation');

tbHolesSub2x = tbHolesSub2x & ~tbClosed;

%% Laplace interpolate remaining
tLap = LaplaceMultiplier(tLin, tbHolesSub2x);
% cent(tLap); title('Laplace interpolation');

%%
tbDom2x = Resize3(tbDom1x,2);
cviRangeSub2x = Box2Range(mBoxSub2x);
tbDomSub2x = tbDom2x(cviRangeSub2x{:});

% Downsample to 1x subvolume
tbFilledSub2x = isfinite(tLap) & tbDomSub2x;
mFilledSub2x = log2sub3d(tbFilledSub2x);
mFilled2x = mFilledSub2x + viLowerSub2x - 1;
mFilled1x2 = round(mFilled2x/2);

vFilled2x = tLap(tbFilledSub2x);
tVol = accumarray(mFilled1x2', vFilled2x, viDim1x, @mean, nan);

% Fill original 1x volume
% cent(tVol); title('Downsampled')

Str('Gridding complete.');

%% Output
if nargout > 1
    oIntermediate = Struct(tSub2x, tLin, tLap);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
