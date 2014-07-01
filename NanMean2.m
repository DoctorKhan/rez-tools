function res = NanMean2(mtx)

% NanMean2;
%
%
%
% Khan 10/24/2011

%% Default params

%% Initialize
mtx(isinf(mtx)) = nan;

%% Main
res = squeeze(nanmean(nanmean(squeeze(mtx), 1), 2));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
