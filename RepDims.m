function [mBig, mSmall, vbDimMap] = RepDims(mBig, mSmall)

% [mBig, mSmall, vbDimMap] = RepDims(mBig, mSmall);
%
% Expand a matrix mSmall to match the size of mBig.
%
% Khan 01/03/2011

bSwap = length(size(squeeze(mSmall))) > length(size(squeeze(mBig)));
   
if bSwap
    [mBig,mSmall] = swap(mBig,mSmall);
end

%% Initialize
viDimBig = size(mBig);
viDimSmall = size(mSmall);
viDimRep = viDimBig;
vbDimMap = false(1, length(size(mBig)));

%% Main 1
for iDim = 1:length(viDimSmall)
    vbMatch = (viDimSmall(iDim) == viDimBig) & ~(viDimRep == 1);
    iInBig = find(vbMatch, 1, 'first');
    viDimRep(iInBig) = 1;
    vbDimMap(iInBig) = true;
end

mSmall = repmat(mSmall, viDimRep);


if bSwap
    [mSmall mBig] = swap(mBig,mSmall);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
