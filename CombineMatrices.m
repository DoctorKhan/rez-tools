function mOut = CombineMatrices(varargin)

% mOut = CombineMatrices(varargin);
%
%
%
% Khan 09/02/2010

%% Default params


%% Initialize

if iscell(varargin{1})
    cmIn = varargin{1};
else
    cmIn = varargin;
end

%% Main
if islogical(cmIn{1})
for ii = 1:numel(cmIn)
    if isempty(cmIn{ii}), continue; end
    if ~exist('mOut', 'var'), mOut = zeros(size(cmIn{ii})); end
    mOut = mOut + ii*cmIn{ii};
end % Function
else
for ii = 1:numel(cmIn)
    if isempty(cmIn{ii}), continue; end
    if ~exist('mOut', 'var'), mOut = nan(size(cmIn{ii})); end
    mOut(isfinite(cmIn{ii})) = cmIn{ii}(isfinite(cmIn{ii}));
end % Function
end
%% Note: type "doc hungarian" for variable prefix explanation.
