function tCI = CalcConf(tData, fInterval, iDim)

% tCI = CalcConf(tData, fInterval, iDim);
%
%
%
% Khan 04/30/2012

%% Default params
Default fInterval = 0.68
Default iDim = 1;

%% Initialize
if fInterval > 1
    fInterval = fInterval/100;
end

if fInterval > 1
    error('Cannot choose interval greater than 100%.');
end

viDim = size(tData);
for iDim = [iDim:ndims(tData) 1:iDim-1];
    if viDim(iDim) > 1
        break
    end
end

if viDim(iDim) < 2
    tCI = [nan nan];
    return
end

%% Main
tData = sort(tData, iDim);

[mData, oBack] = CycleLast(tData, iDim, 2);
viDim = size(mData);
tCI = nan([2 viDim(2:end)]);

vFin = sum(isfinite(mData));

vHigh = vFin*fInterval;
viHigh = floor(vHigh);

vLow = vFin*(1-fInterval);
viLow = floor(vLow);
[nPts, nCols] = size(mData);

v  = (0:nPts-1)*nCols;
ivLow = VecSum(v, viLow);
%%
A = vLow - viLow;
m1 = reshape(mData(ivLow), size(A));
m2 = reshape(mData(ivLow+1), size(A));
%%
ctCI{1} =  A.*m1 + (1 - A).*m2;
%%
ivHigh = VecSum(v, viHigh);

A = vHigh - viHigh;
m1 = reshape(mData(ivHigh), size(A));
m2 = reshape(mData(ivHigh+1), size(A));
ctCI{2} = A.*m1 + (1 - A).*m2;

%%
tCI = cat(1, ctCI{:});
tCI = CycleBack(tCI, oBack);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
