% function TestCombineBootParamsAll

% TestCombineBootParamsAll;
%
%
%
% Khan 10/24/2011

%% Default params


%% Initialize
HemoInit

%% Main
voROIFiles = FindHemoFiles;
[voFailed, voResult] = CombineBootParamsAll(voROIFiles);
LamFitTable(voHemo1, voROIFiles);
% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
