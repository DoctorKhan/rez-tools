function [tW, tX, tY, tZ, tR] = ExampleTMat(iMaxRadius)

% [tW, tX, tY, tZ, tR] = ExampleTMat;
%
% W = W(X, Y, Z)
%
% 0 = Domain, 1 = Inner Bound, -1 = Outer Bound, 3 = Other
%
% Khan 06/24/2010

%% Default params
if ~exist('iMaxRadius', 'var'), iMaxRadius = 50; end

%% Initialize
[tX, tY, tZ] = meshgrid(-iMaxRadius:iMaxRadius);
tR = sqrt(tX.^2 + tY.^2 + tZ.^2);

rMin = 0.6*iMaxRadius;
rMax = 0.7*iMaxRadius;
rWidth = 0.01*iMaxRadius;

%% Main
tW = 3*ones(size(tR));
tW(tR > (rMin - rWidth) & tR < (rMax + rWidth)) = 0;
tW(tR > (rMin - rWidth) & tR < (rMin + rWidth)) = 1;
tW(tR > (rMax - rWidth) & tR < (rMax + rWidth)) = -1;


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
