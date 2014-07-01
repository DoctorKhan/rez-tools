function bIsMesh = isMesh(oMesh)

% bIsMesh = isMesh(oMesh);
%
%
%
% Khan 03/16/2012
 
%% Default params


%% Initialize


%% Main
bIsMesh = isa(oMesh, 'RawMesh') || isstruct(oMesh) && isfield(oMesh, 'vertices');

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
