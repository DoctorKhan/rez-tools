function [m, N] = NormalizeByCol(m, iCol)

% [m, N] = NormalizeByCol(m, iCol);
%
%
%
% Khan 11/09/2010

%% Default params
if notDefined('iCol'), iCol = ceil(size(m, 2)/2); end

%% Initialize

%% Main
N = nanmean(m(:, iCol));
m = m / N;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
