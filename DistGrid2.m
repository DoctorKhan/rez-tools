function [tVol, oIntermediate] = DistGrid2(mCoords1x, vValues, tbDom1x, viGridSpacing, nSamples)

% [tSub2x, tbHolesSub2x] = DistGrid2(mCoords1x, vValues, tbDom1x, viGridSpacing, nSamples);
%
%
% Khan 04/19/2012

%% Default params
% Default viGridSpacing = [1 3 5 7 11 13 17 19 23 29];
nIters = 10;
Default viGridSpacing = [1 1 2 2 3 3 5 5];
viGridSpacing = repmat(viGridSpacing, 1, nIters);

%% Initializes
nKernel = 100;
vKernel = KernelCubic(nKernel);

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
% mBoxCoords1x = BoundingBox(mCoords1x);
if notDefined('tbDom1x')
    viDim1x = GetDimFromAnat;
%     ceil(diff(mBoxCoords1x)) + 1;
    tbDom1x = true(viDim1x);
else
    viDim1x = size(tbDom1x);
end


if isscalar(tbDom1x), tbDom1x = repmat(tbDom1x, 1, 3); end
if numel(tbDom1x) == 3, tbDom1x = true(tbDom1x); end

% Subvolume 1x
Str('Subvolume 1x data')
[mBoxSub1x, cviRangeSub1x, viDimSub1x] = SubVol(tbDom1x);

Str('Upsample 2x')
% Upsample to 2x
mCoords2x = 2*mCoords1x;
tbHoles2x = Resize3(tbDom1x, 2);
mBoxSub2x = 2*mBoxSub1x;

% Subvolume 2x
Str('Subvolume 2x data')
[tbHolesSub2x, viLowerSub2x, viDimSub2x] = SubVol(tbHoles2x, mBoxSub2x, 'tSub');
mTrajCoordsSub2x = mCoords2x - viLowerSub2x + 1;

% Misc
tSub2x = nan(viDimSub2x);
% mDirs = CubePts; %(1:7,'pos');
nHoles0 = total(tbHolesSub2x);
nPts = length(mCoords1x);

%% Main
for iGridSpacing = viGridSpacing
    % Sample rate
    Str('Grid spacing =', iGridSpacing, '.')
    
    % Rounded traject coords on 2x grid
    mTrajSub2xGrid = round(mTrajCoordsSub2x/iGridSpacing)*iGridSpacing;
    nMaxShift = round((iGridSpacing-1)/2);

    % Random displacement within grid radius for anti-aliasing
    viShift = randi([0 nMaxShift], [1 nPts]);
    viDir = randi(26, [1 nPts]);    
    miDisp = CubePts(viDir).*viShift;
    
    mTrajSub2xShift = EnforceBounds(mTrajSub2xGrid + miDisp, viDimSub2x);
    viTrajSub2xShift    = coords2Indices(mTrajSub2xShift, viDimSub2x);
    
    % Holes coinciding with desired grid points
    vbTrajSub2xShHoles = tbHolesSub2x(viTrajSub2xShift);
    
    % Select voxels to grid
    mTrajSub2xHoles = mTrajSub2xShift(:,vbTrajSub2xShHoles);
    vValTrajSub2xShHoles = vValues(vbTrajSub2xShHoles);
    
    % Restrict coordiates to iGridSpacing diameter of grid center
    mTrajSub2xShHoles = mTrajCoordsSub2x(:,vbTrajSub2xShHoles);
    
    % Weights
    gridRadius = iGridSpacing*sqrt(2)/2;
    
%     viR = round(Mag(mTrajSub2xHoles - mTrajSub2xShHoles)*nKernel/gridRadius);
%     vbGoodRadius = viR < nKernel;
%     vWeights = zeros(1, length(viR));
%     vWeights(vbGoodRadius) = VertVec(vKernel(viR(vbGoodRadius)));
    vWeights = VertVec(gridRadius - Mag(mTrajSub2xHoles - mTrajSub2xShHoles));
    vWeights(vWeights<0) = 0;
    
    vMoments = VertVec(vWeights.*vValTrajSub2xShHoles); % Compute moments   
    % Sum the moments
    tAccum   = accumarray(mTrajSub2xHoles', vMoments, viDimSub2x, @sum, nan);

    % Norm factor (density correction)
    tDensity = accumarray(mTrajSub2xHoles', vWeights, viDimSub2x, @sum, nan);    
    
    tNorm = tAccum ./tDensity;
    
    tSub2x(tbHolesSub2x) = tNorm(tbHolesSub2x);
    % Identify hole
    tbFailed = tbHolesSub2x & ~isfinite(tSub2x);
    
    if total(tbFailed) == 0, break; end
    nHoles = total(tbFailed);
    
    progFrac = 1-nHoles/nHoles0;
    TextWaitbar(progFrac);
    
    tbHolesSub2x = tbFailed;
end

cent(tSub2x); title('Gridded');

%% Repair
% Linearly interpolate holes
tbHolesSub2x = tbHolesSub2x & ~isfinite(tSub2x);
vInterped = LinInterpC(tSub2x, tbHolesSub2x);
vbInterpSuccess = isfinite(vInterped);

% Identify closed holes
viHoles = log2ind3d(tbHolesSub2x);
viClosedHoles = viHoles(vbInterpSuccess);

tLin = tSub2x;
tLin(viClosedHoles) = vInterped(vbInterpSuccess);
cent(tLin); title('Linear interpolation');

%% Laplace interpolate remaining
tbHolesSub2x(viClosedHoles) = false;
tLap = LaplaceMultiplier(tLin, tbHolesSub2x);
cent(tLap); title('Laplace interpolation');

%%
Str('Downsampling');
% Downsample to 1x subvolume
tbFilled = isfinite(tLap);
mFilledSub2x = log2sub3d(tbFilled);
mFilled2x = mFilledSub2x + viLowerSub2x - 1;
mTrajSub2xHoles = round(mFilled2x/2);

vDownValues = tLap(tbFilled);
tVol = accumarray(mTrajSub2xHoles', vDownValues, viDim1x, @mean, nan);

cent(tVol); title('Downsampled')

%% Output
oIntermediate = Struct(tSub2x, tLin, tLap);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
