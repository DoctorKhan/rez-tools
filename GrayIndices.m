function [viIndices, tbVol, viDim] = GrayIndices(oView,ivIndices)

% [viIndices, tbVol ] = GrayIndices(ivIndices,view);
%
%
%
% Khan 12/14/2011

%% Initialization
viDim = GetDimFromAnat(oView);
viCoords = GrayCoords(oView);

%% Main
viIndices = sub2ind3d(viCoords, viDim);

if defined('ivIndices')
	viIndices = viIndices(ivIndices);
end

if nargout > 1
	tbVol = sub2log3d(viCoords, viDim);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
