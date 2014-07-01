% function TestGrid3

% TestGrid3;
%
%
%
% Khan 06/05/2012
 
%% Default params

%% Initialize
iGridSize = 30;
viDim = [iGridSize, iGridSize, iGridSize];
r0 = 2;

% Main
tV = RadialCoordinate(iGridSize, (iGridSize+1)/2);
[tX tY tZ] = MeshGrid2(viDim);

tbDomain = sqrt(tX.^2 + tY.^2 + tZ.^2) < iGridSize/2;
tbDomain = true(viDim);

mCoords = log2sub3d(tbDomain);
[tX2 tY2 tZ2] = Foliate(mCoords);

mBox = [1 1 1; viDim];tic
% G = Grid3(tX(:), tY(:), tZ(:), tV(:), tX2(:), tY2(:), tZ2(:), mBox, r0);toc
% G = Grid3(tX(:));
%
% t = sub2mat3d(mCoords, G', viDim);
% cent(t);
% end % Function
%

tic; tt = DistGrid(mCoords, tV(:)); toc;
cent(tt)
%% Note: type "doc hungarian" for variable prefix explanation.
