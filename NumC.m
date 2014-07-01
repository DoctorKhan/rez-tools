function [nLength, iDim] = NumC(mCoords, nLength)

% nCoords = numc(mCoords, nLength);
%
%
%
% Khan 04/25/2012

%% Initialize
viDim = size(mCoords);

%% Main
if numel(mCoords) < 9
    iDimMax = max(viDim(viDim(:) < 4));
    Default nLength = iDimMax;
%     Str('Warning: number of coordinates =', nLength, 'possibly misidentified from ambiguous matrix size', viDim, '.');
else
    viDim(viDim == 1) = [];
    nLength = min(viDim);
    Default nLength = 1;
end

iDim = find((size(mCoords) == nLength), 1, 'first');
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
