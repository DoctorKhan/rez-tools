function m = MultiMean(m, vi)

% m = MultiMean(m, vi);
%
% Take the mean across multiple dimensions (vi).
%
% Khan 02/03/2011

%% Default params


%% Initialize
vi = sort(vi, 'descend');

%% Main
for ii = vi
    m = mean(m, ii);
end % Function

m = squeeze(m);

%% Note: type "doc hungarian" for variable prefix explanation.
