% TestLamHRF;
%
%
%
% Khan 07/26/2011

%% Initialize
clear global; HemoInit

oHemo = oGreene; cds(oHemo);

Default oView = InitHidden('Volume', 'Timed')

Default sROI = "V1p";

oView, xROI, voBins, tsSliceBlock, vNormDepthMap, mResam
%% Main
% Execute

LamHRF(oView, V1p, '', tsSliceBlock, voDepthBins, 'Save');
% [oView, oResults] = LamHRF(oView, sROI, voDepthBins, tsSliceBlock);



%% Note: type "doc hungarian" for variable prefix explanation.
