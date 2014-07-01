function [xA, xBOut, viMap] = MixedMatch2(xA, xB)

% [xA, xBOut, viMap] = MixedMatch2(xA, xB);
%
% Expand a matrix through repmat to match the size of another.
%
% Khan 01/03/2011
% Khan 08/18/2011 - Recoded so it actually works.

%% Initialize
viSizeA = size(xA);
viSizeB = size(xB);

% if isempty(intersect(viSizeA, viSizeB))
% 	Str('A:', viSizeA, ', B:', viSizeB)
% 	error('Inputs do not have any corresponding dimensions.')
% end

nDimsA = ndims(xA);
nDimsB = ndims(xB);

if isempty(xA) || isempty(xB)
    xBOut = xB; viMap = [];
    return
end

if sum(viSizeA > 1) < sum(viSizeB > 1)
	 [xBOut, xA, viMap] = MixedMatch2(xB, xA);
	 return
end

%% Main
viMap = MatchDims(xA, xB);
viSizeA(viMap) = [];

viRepDim = [ones(1, nDimsB), viSizeA];

xB2 = squeeze(repmat(xB, viRepDim));

viMap = MatchDims(xA, xB2);

viPermute(viMap) = 1:nDimsA;
xBOut = permute(xB2, viPermute);
    
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
