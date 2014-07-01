function [tData, oBack] = CycleFirst(tData, iDim, nDimsDesired, iPostShift)

% [tData, oBack] = CycleFirst(tData, iDim, nDimsDesired, iPostShift);
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
tData = DimShift(tData, 1-iDim);

% Reshape
viDim = size(tData);
ciDim = [num2cell(viDim(1:nDimsDesired-1)), {[]}];
tData = reshape(tData, ciDim{:});

if defined('iPostShift')
tData = DimShift(tData, iPostShift);
end

iShift = 1-iDim;
oBack = Struct(viDim, iShift);
oBack.ciDim = ciDim;
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
