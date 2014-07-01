function [nCoords iDim] = NumP(mCoords, iDim)

% nCoords = NumP(mCoords, iDim);
%
%
%
% Khan 04/25/2012
 
%% Default params
Default iDim = 3;

%% Initialize
viDim = size(mCoords);

%% Main
if ~any(viDim == iDim), iDim = min(viDim); end
viDim(find(viDim == iDim, 1, 'first')) = [];
viDim(viDim == 1) = [];

Default viDim = 1;

nCoords = viDim(1);

% if nCoords < iDim
%     Str('Warning: assuming number of coordinates =', iDim, 'in matrix size', size(mCoords));
% end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
