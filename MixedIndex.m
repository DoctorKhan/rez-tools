function [vOut, xmOut, xmOutNan] = MixedIndex(xmA, xmbB, iDims)

% [vOut, xmOut, xmOutNan] = MixedIndex(xmA, xmbB, iDims);
%
%
%
% Khan 01/03/2011

%% Default params


%% Initialize

%% Main
[~, xmbB2, vbDimMap] = MixedMatch(xmA, xmbB);

vOut = xmA(xmbB2);

viReshape = size(xmbB2);
viReshape(vbDimMap) = 1;
viReshape(find(vbDimMap, 1)) = total(xmbB);

xmOut = reshape(vOut, CollapseVec(viReshape, vbDimMap));

xmOutNan = xmA;
xmOutNan(~xmbB2) = nan;

if defined('iDims'), vOut = xmOut;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
