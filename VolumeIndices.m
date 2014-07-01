function [viIndices, tbVol, viDim] = VolumeIndices(oHemo, ivIndices)

% [viIndices, tbVol ] = VolumeIndices(ivIndices,view);
%
%
%
% Khan 07/20/2011

%% Initialization
viDim = GetDimFromAnat;
viCoords = VolumeCoords(oHemo);

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
