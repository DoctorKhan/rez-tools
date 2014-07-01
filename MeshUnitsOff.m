function oMesh = MeshUnitsOff(oMesh)

% oMesh = MeshUnitsOff(oMesh);
%
%
%
% Khan 04/05/2012

%% Default params


%% Initialize
Default oMesh.mmPerVox = GetVoxelSize;
Default oMesh.bUnits = true;

%% Main
if oMesh.bUnits;
    Default oMesh.origin = zeros(3,1);
    Default oMesh.mmPerVox0 = oMesh.mmPerVox;
    Default oMesh.fov = GetDimFromAnat;
    
    [vertices, origin, fov, mmPerVox] = Destruct(oMesh);
    vertices = (vertices-origin+fov/2)./mmPerVox;
    
    oMesh.vertices = vertices;
%     oMesh.origin = zeros(3,1);
%     oMesh.mmPerVox = [1 1 1];
%     oMesh.bUnits = false;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
