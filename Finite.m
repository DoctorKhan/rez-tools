function [tGood, tbGood, mbGood] = Finite(tIn,iDim)

% [tGood tbGood] = Finite(tIn,iDim);
%
% Removes non-finite values.
%
% Khan 01/17/2012

%% Default params
Default iDim = 1

%% Initialize
tIn = HorzMat(tIn);

%% Main
if isempty(tIn)
    tGood = [];
    return
end

if islogical(iDim)
    tbGood = iDim;
else
    mbGood = all(isfinite(tIn),iDim);
    tbGood = MixedMatch(mbGood, tIn);
end

[tIn, tbGood] = MixedMatch(tIn, tbGood);

viDim = size(tIn);

if any(setdiff(size(tbGood), size(tIn)))
    for iDim2 = setdiff(size(tbGood), size(tIn))
        iDim3 = find(iDim2 == size(tbGood));
        tbGood = all(tbGood, iDim3);
    end
end

vGood = tIn(tbGood);
nGood = numel(vGood);

ciDims = num2cell(viDim);
vbBad = ~isInt(nGood./viDim);
if any(vbBad)
    ciDims{vbBad} = [];
end

try
    tGood = reshape(vGood, ciDims{:});
catch
    tGood = vGood;
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
