function oRaw = MeshNormInterp(oRaw, oMesh, varargin)

% oRaw = MeshNormInterp(oRaw, varargin);
%
%
%
% Khan 04/11/2012

%% Default params
if isempty(oRaw.EvalNorm)
    error('Run NormInit first.');
end

%% Initialize
Default oMesh = RawMesh(oRaw);
oMesh.normals = nan(size(oMesh.vertices));

if isMatrix(oMesh)
    vertices = oMesh; clear oMesh;
    oMesh = RawMesh(oRaw);
    oMesh.vertices = vertices;
end

%% Main
fprintf('Interpolating normals...');

[mVerts, vbFin] = Finite(oMesh.vertices);
oRaw.normals(vbFin) = oMesh.EvalNorm.Eval(mVerts);
disp('done.');
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
