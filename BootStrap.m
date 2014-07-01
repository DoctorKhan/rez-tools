function mBoot = BootStrap(m, nBootstraps)

% BootStrap;
%
% General bootstrap
%
% Khan 04/08/2010

%% Default params


%% Initialize
nTrials = size(m,2);
nPts = size(m, 1);
mBoot = zeros(nPts, nBootstraps);

%% Main
for iBoot = 1 : nBootstraps
    % 1. Resample data - sample with replacements the trial numbers
    vResampledTrials = randsample(nTrials, nTrials, 'true');

    % Mean across resampled trials
    mBoot(:,iBoot) = mean(m(:, vResampledTrials), 2);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
