function [oMesh, oMesh2] = StepTraject(oMesh, oMesh2, oRawiv)

% oMesh = StepTraject(oMesh, oRawiv, tG, nIters);
%
%
%
% Khan 02/28/2012

%% Default params

%% Initialize
%% Main
%%
if ~isfield(oMesh, 'normals'); tic
    Str('Calculating normals...');
    fv = MeshMrVista2Matlab(oMesh); % To calculate normals
    fv.vertexnormals = NormalizedVector(isonormals(double(oRawiv.tData), fv.vertices)'); % calc normals
    clear oRawiv
    oMesh = MeshMatlab2mrVista(fv, 1); % revert format
    toc
end

%%
Destruct(oMesh);

nVerts = length(vertices);
vSteps = 0:0.2:10; nSteps = length(vSteps);

tSteps = repmat(vSteps', [1 nVerts 3]);
mSteps = reshape(tSteps,[],3);
vDist = mSteps(:,1);

tNorm = repmat(reshape(permute(-normals, [2 1]), 1, [],3), [nSteps 1 1]);
tVert = repmat(reshape(permute(vertices, [2 1]), 1, [],3), [nSteps 1 1]);
tTra = tSteps.*tNorm + tVert;
mTra = reshape(tTra, [],3);
%%
tic; oMesh2.nearest = nearpoints3d(oMesh2.vertices, mTra); toc

%% Output
oMesh2.vDist = HorzVec(vDist);

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
