function [meanVal, ci, mBootDist] = Bootstrap(mData, nBootstraps)

% [meanVal, ci, mBootDist] = Bootstrap(mData, nBootstraps);
%
% General bootstrap calculation. 
% mData = nPointsPerTrial x nTrials
%
% Ress 10/2011
% Khan 04/12/2012 - Added comments

%% Default params
Default nBootstraps = 1000

%% Initialize
nTrials = size(mData,2);

%% Main
% Resample data - sample with replacements the trial numbers
vResampledTrials = RandSample(1:nTrials, [1, nTrials*nBootstraps]);

% Prepare data for resampling
vData = repmat(VertVec(mData), [nBootstraps, 1]);

% Resample
mResampled = reshape(vData(vResampledTrials(:)), [nBootstraps, nTrials]);

% Mean across resampled trials creates new distribution
mBootDist = mean(mResampled, 2); 

%% Output
% Get mean and confidence interval
meanVal = mean(mBootDist);
ci = CalcConfidenceIntervals(mBootDist);


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
