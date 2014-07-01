function vbMask = sub2mask(mCoords, mMapCoords)

% vbMask = sub2mask(mCoords, mMapCoords);
%
%
%
% Khan 07/21/2011

%% Default params
Default mMapCoords = getSelectedView('coords')

%% Arg handling
if isstruct(mMapCoords), mMapCoords = mMapCoords.coords; end
if isstruct(mCoords),    mCoords    = mCoords.coords;    end

%% Initialize

%% Main
[~, viMapIndices] = intersectCols(mMapCoords, mCoords);
vbMask = sub2log(viMapIndices, length(mMapCoords));
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
