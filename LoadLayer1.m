function [ mLayer1Coords, viLayer1Ind, cviLamInd ] = LoadLayer1(view, varargin)

% [ mLayer1Coords, viLayer1Ind, cviLamInd ] = LoadLayer1(view, varargin);
%
%
%
% Khan 08/12/2011

%% Default params

%% Initialize
if ~Option('force') && exist('Layer1.mat', 'file')
	load Layer1
	return
end

%% Main
Default view = initHiddenGray;
view = loadAnat(view);
view = loadSpatialGradient(view);

%% Main
[mLayer1Coords, viLayer1Ind] = GetLayerCoords(view, 1); % Layer 1 coordinates & indices
view = LoadLaminarIndices(view);

cviLamInd = view.laminarIndices;
save Layer1 mLayer1Coords viLayer1Ind cviLamInd
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
