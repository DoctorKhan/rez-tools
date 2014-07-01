% function TestNormalizedDepthMap

% TestNormalizedDepthMap;
%
%
%
% Khan 11/03/2011

%% Default params


%% Initialize


%% Main
if notDefined('oView'), oView = InitHidden('Volume'); end
oView = NormalizedDepthMap(oView, '', 'Load');

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
