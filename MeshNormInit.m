function oRaw = MeshNormInit(oRaw, oRawivInterp, varargin)

% oRaw = MeshNormInit(oRaw, varargin);
%
%
%
% Khan 04/11/2012

%% Main
Str('Initializing interpolant...');
voMesh = oRawivInterp.MeshArray(oRaw);

TextWaitbar(0, 'Computing interpolant...');
v = []; n = [];
for oSurf = voMesh;
    v = [v oSurf.vertices];
    n = [n oSurf.normals];
    TextWaitbar(oSurf.iNum/oSurf.nTot);
end

oRaw.EvalNorm = InterpScattered(v, n);
end

%% Note: type "doc hungarian" for variable prefix explanation.
