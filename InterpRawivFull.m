function oRawiv = InterpRawivFull(oRawiv, viDim)

% oRawiv = InterpRawivFull(oRawiv, viDim);
%
%
%
% Khan 05/12/2012

%% Initialize

%% Default params
Default viDim = GetDimFromAnat;

%% Main
oVolPts.vertices = MeshGrid2(viDim);
vIntData = LinearInterp(oRawiv, oVolPts);

oRawiv.tData = reshape(vIntData, viDim);
oRawiv.mBox = [1 1 1; viDim];

oRawiv.Update;

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.