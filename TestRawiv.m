% function TestRawiv

% TestRawiv;
%
%
%
% /bin/bash: echokhan: command not found 03/27/2012
 
%% Default params


%% Initialize


%% Main
clx; cd /export/data/mri/Anatomy/GreeneHR/Cortex/Left;
oVol = Seg('GreeneLeft.Class');

oVol.iType = 2; oVol.sType = 'anat';

oMesh = oVol.Mesh(5);
fin(oMesh)
%%
% oRef = oRef.Refine(3);
% fin(oRef)
% oRef.iRefine
%%
[oMesh2 oVol2 vAdj] = AlignMesh2Vol(oMesh, oVol);
%%
SliceMeshOnVolume(oMesh.Translate([0.021625 0.16556 0.29069]), oVol);
SliceMeshOnVolume(oMesh.Translate([0.082018 -0.11339 0.32558]), oVol);
SliceMeshOnVolume(oMesh.Translate([0.56717 -0.12837 -0.22556]), oVol);
% min mean on seg: [0.021625 0.16556 0.29069]  0.4833 -> 0.48276
% min std on anat: [0.082018 -0.11339 0.32558] 19.4224 -> 19.3791

% min std on seg: [0.56717 -0.12837 -0.22556] std: 0.073274 -> 0.059788

%% Refined 5
Final mesh to volume adjustment: [0.021625 0.16556 0.29069]
Elapsed time is 425.670425 seconds.
Initial error: 0.48334
Final error: 0.48276



[m s] = InterpMeshOnVol(oMesh2, oVol)
%%
oMesh = oMesh.Translate(-vAdj);
SliceMeshOnVolume(oMesh, oVol)
%%
o = oClass.AlignMesh2Vol;


% end % Function
 
%% Note: type "doc hungarian" for variable prefix explanation.
