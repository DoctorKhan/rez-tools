% function TestGrid3

% TestGrid3;
%
%
%
% Khan 06/05/2012
 
%% Default params

%% Initialize
iGridSize = 150;
viDim = [iGridSize, iGridSize, iGridSize];
r0 = 2;

% Main
tV0 = RadialCoordinate(iGridSize, (iGridSize+1)/2);
tV = tV0 + rand(viDim);
[tX tY tZ] = MeshGrid2(viDim);

mCoords = [tX(:) tY(:) tZ(:)]';

tic; tt = DistGrid(mCoords, tV(:), true([iGridSize iGridSize iGridSize])); toc;
cent(tt);
%% Note: type "doc hungarian" for variable prefix explanation.
