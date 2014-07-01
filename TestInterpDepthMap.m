% TestInterpDepthMap;
%
%
%
% Khan 09/29/2011

%% Default params


%% Initialize
HemoInit
oHemo = oGreene;
oHemo.sHemi = 'Left';
nSamples = Inf; maxVal = 5;
vNormBounds = [-1 2];

% a = '/White-Pia'; b = '/Deep-White'; c = '/Pia-Extra'; ctbDomain = combstr(pwd, {[a a],[b b], [c c]});
%% Main
[ tCombinedDomain, tbDomain ] = Domains4DepthMap(oHemo, nErodeLayers, nExtraLayers);
voMap = Struct(nSamples, maxVal, vNormBounds, tCombinedDomain, tbDomain);

%%
d = zeros(size(voMesh(1).distance));
for ii = 2:16
    d(:,ii) = d(:,ii) + voMesh(ii).distance(:);
end
a = Cell2Mat({voMesh.distance});
b = cumsum(a');

%%
oMeshFinal = GetMesh(oHemo, 'pia');

oThick = Mesh2Thick(voMesh);

oTrajFinal.mCoords = voMesh(end).vertices;
oTrajFinal.vDepth = oThick.mThicks;
oTrajFinal.mPtNorm = voMesh(end).normals;
[oMeshFinal2, ~, vInterThick] = GridTrajOnMesh(oTrajFinal, oMeshFinal);
%%
[oWhite, oPia] = GetMesh(oHemo); % vertices in physical units

[tDepth, tNormDepth, tbGood ] = InterpDepthMap(voMap, oWhite, oPia, oHemo, voMesh);
cent(tDepth)
cent(tNormDepth)
cent(tDepth./tNormDepth)

%% Note: type "doc hungarian" for variable prefix explanation.
