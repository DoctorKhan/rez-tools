
% function TestVol2Mesh

% TestVol2Mesh;
%
%
%
% Khan 05/22/2012
 
%% Default params


%% Initialize
HemoInit

%% Main
oSeg = Seg('KhanLeft.Class');
oWhiteVol = oSeg.White;
oMesh = oWhiteVol.Mesh(0);
oMesh.Box - oWhiteVol.Box

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
