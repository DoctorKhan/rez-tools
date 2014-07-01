% function TestStandardHemo

% TestStandardHemo;
%
%
%
% Khan 11/09/2011

%% Default params
Default oView = InitHidden('Volume')

%% Initialize
HemoInit
% oView = StandardHemo(oSim, oView);
oView = StandardHemo(voHemo, voBaseROIs, voDepthBins);
%% Main


% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
