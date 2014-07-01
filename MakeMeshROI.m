function view = MakeMeshROI(view, vertices)

% view = MakeMeshROI(view);
%
%
%
% Khan 12/20/2011
 
%% Default params


%% Initialize

%% Main
if ~isfield(view, 'mesh') 
	view.mesh{1} = readMesh;
elseif all(cellfun(@isempty, view.mesh))
	view.mesh{end} = readMesh;
end

Destruct view.mesh{end} -> vertices mmPerVox name

Default mmPerVox = GetVoxelSize(oHemo, 'func')
mCoords = round(MatrixVectorDiv(vertices([2 1 3],:), mmPerVox));
view = newROI(view, name, 'select', '', mCoords);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
