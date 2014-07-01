% TestLaminarFits;
%
%
%
% Khan 08/08/2011

%% Default params

%% Initialize
oROIFile = FindHemoFiles(1);

%% Main
o = Load(oROIFile);
Destruct(o(1));
vLaminaPts = [oROI.voBins.middle];

oFit = LaminarFits(omBootParams, vLaminaPts);
%%
% [vLaminaPts, vData] = SampleCoords;
% vFit = polyfit(vLaminaPts, vData, iOrder); % [ -1 0 1 ] descending degree


%% Note: type "doc hungarian" for variable prefix explanation.
