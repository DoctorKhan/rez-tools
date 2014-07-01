function NormBall(oMesh, nElements, sDotStyle, sArrowStyle)

% NormBall(pRaw);
%
%
%
% Khan 03/16/2012

%% Default params
Default sDotStyle = "r." & sArrowStyle = "b"
Default nElements = 1000

%% Initialize
if ~isMesh(oMesh)
    oMesh = RawMesh(oMesh);
end

%% Main
Destruct(oMesh);
b = unique(round(linspace(1, size(vertices,2), nElements)));
s = vertices(:,b);
f = normals(:,b);
plot3s(s, sDotStyle); hold on
quiver3s(s,s+f, sArrowStyle); hold off
title(Str('Radius', Radius(oMesh)));
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
