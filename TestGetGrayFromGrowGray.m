%
%
%
% Khan 12/14/2011

%% Default params


%% Initialize
sSubject = 'Greene';
sBrainRegion = 'Cortex';
sHemisphere = 'Both';
nGrayLayers = 5;

%% Main
[ tbGray, mmPerVox ] = GetGrayFromGrowGray(sSubject, sBrainRegion, sHemisphere, nGrayLayers);
cent(tbGray, 1, 168)
% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
