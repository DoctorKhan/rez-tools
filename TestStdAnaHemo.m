% function TestStdAnaHemo

% TestStdAnaHemo;
%
%
%
% Khan 10/25/2011

%% Default params


%% Initialize
oROI = voBaseROIs(1);
oHemo = voHemo(1); cds(oHemo);
clear global

Default oView = InitHidden('Volume'); 


%% Main
oView = StdAnaHemo(oHemo, oROI, oView, 'Load', 'Load');

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
