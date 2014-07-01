function viMap = MatchDims(xA, xB)

% viMap = MatchDims(xA, xB);
%
%
%
% Khan 08/17/2011

%% Default params


%% Initialize


%% Main
% nDimsA = ndims(xA);
nDimsB = ndims(xB);

viSizeA = size(xA);
viSizeB = size(xB);

viMap = zeros(1, nDimsB);

for iDimB = 1:nDimsB
	iDimSizeB = viSizeB(iDimB);
	iMatchInA = find(viSizeA == iDimSizeB, 1, 'first');
	
	if isempty(iMatchInA), continue; end
	
	viMap(iDimB) = iMatchInA;
	viSizeA(iMatchInA) = 0;
end

viMap(viMap == 0) = [];

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
