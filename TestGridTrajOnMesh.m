% function TestGridTrajOnMesh

% TestGridTrajOnMesh;
%
%
%
% Khan 02/09/2012

%%

%%
HemoInit
oHemo = oGreene;
oHemo.sHemi = 'Left';
cd(AnatPath(oHemo, '3DMeshes', 'White-Pia'))
%%
[tC tD] = ReadThicknessPCD;

cds oHemo
[~, oPia] = GetMesh(oHemo);

viDim = GetDimFromAnat;
%%
[oMesh, vInterThick] = GridTrajOnMesh(tC, tD, oPia, viDim);

%% Note: type "doc hungarian" for variable prefix explanation.
