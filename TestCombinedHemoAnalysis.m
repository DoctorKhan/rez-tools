% function TestCombinedHemoAnalysis

% TestCombinedHemoAnalysis;
%
%
%
% Khan 09/19/2011

%% Default params


%% Initialize
pData='Boot*';
oHemo.sSession = 'Combined';
oHemo.sSubject = 'All Subjects';

%% Main
% vTop = [4 1.1 1.5 1.5];
% vBot = [2 2 8 1.1 ];
% vScale = [vTop vBot];
CombineBootHRFParams(1)
%%
FiguresHRF(oHemo, pData, '');

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
