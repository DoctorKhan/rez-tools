function mIn = NanMean(mIn, viDims)

% mIn = NanMean(mIn, viDims);
%
%
%
% Khan 08/31/2011
% Khan 10/24/2011

%% Default params
Default viDims = 1

%% Initialize
mIn(isinf(mIn)) = nan;

%% Main
for iDim = viDims
	mIn = nanmean(mIn,iDim);
end

mIn = squeeze(mIn);
if isempty(mIn), mIn = nan; end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
