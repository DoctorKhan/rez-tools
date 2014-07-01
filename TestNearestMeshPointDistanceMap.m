% function TestNearestMeshPointDistanceMap

% TestNearestMeshPointDistanceMap;
%
%
%
% Khan 01/03/2012
 
%% Default params


%% Initialize

load TestNearestMeshPointDistanceMap.mat
%% Main
ctbDomain{1} = ctbDomain{1} & ~SphereVolume(300,60);

% Inward from gray/white depth map
[cmThicks{1}, cmDepths{1}, cmCurves{1}, mWhiteMesh] = NearestMeshPointDistanceMap(oWhite, ctbDomain{1}, ctThicks{2}, 'inward');
% Outward from pial depth map, depths in physical units. mMesh in norm units.
[cmThicks{3}, cmDepths{3}, cmCurves{3}, mPialMesh]  = NearestMeshPointDistanceMap(oPia,   ctbDomain{3}, ctThicks{2}, 'outward');

%%
t = CombineMatrices(ctDepths);
cent(t);

%% Note: type "doc hungarian" for variable prefix explanation.
