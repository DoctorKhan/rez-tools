% function TestDomains4DepthMap

% TestDomains4DepthMap;
%
%
%
% Khan 11/03/2011

%% Default params


%% Initialize
sSubject = 'Greene';
sBrainRegion = 'Cortex';
sHemisphere = 'Right';
nErodeLayers = 5;
nExtraLayers = 5;

%% Main
[ ctbDomain, tCombinedDomain ] = Domains4DepthMap(sSubject, sBrainRegion, sHemisphere, nErodeLayers, nExtraLayers);
cent(tCombinedDomain)
% end % Function
%%
tbWhite = Load('/export/data/mri/Anatomy/SphereHR/Cortex/Both/3DMeshes/Deep-White/Deep-White.mat');
tbGray = Load('/export/data/mri/Anatomy/SphereHR/Cortex/Both/3DMeshes/White-Pia/White-Pia.mat');
tbPial = Load('/export/data/mri/Anatomy/SphereHR/Cortex/Both/3DMeshes/Pia-Extra/Pia-Extra.mat');
tCombined = Load('/export/data/mri/Anatomy/SphereHR/Cortex/Both/CombinedDomain.mat');

cent(tCombined)


%% Note: type "doc hungarian" for variable prefix explanation.
