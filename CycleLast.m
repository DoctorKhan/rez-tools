function [tData, oBack] = CycleLast(tData, iDim, nDimsDesired)

% [tData, viDim] = CycleLast(tData, iDim, nDimsDesired);
%
%
%
% Khan 04/30/2012

%% Default params
Default iDim = 1
Default nDimsDesired = ndims(tData)

%% Initialize
n = ndims(tData);

%% Main
% Permute
iShift = n - iDim;
tData = DimShift(tData, iShift);

% Reshape
viDim = size(tData);
n - 0:nDimsDesired;
viDim = fliplr(viDim);
viDim2 = fliplr(viDim(1:nDimsDesired));
ciDim = [{[]}, num2cell(viDim2)];
tData = reshape(tData, ciDim{:});

%% Output
ciDim = [num2cell(viDim(1:end-1)), {[]}];
oBack = Struct(viDim, iShift, ciDim);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
