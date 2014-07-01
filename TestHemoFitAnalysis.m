% TestHemoFitAnalysis;
%
%
%
% Khan 08/31/2011

%% Default params


%% Initialize
% CNRs
% 80		60			40			20
% 0.1688    0.1675		0.1663		0.1739
%						best
% Subjects
% Greene  0.1476 best
% Khan    0.1676s
% Ress    0.1629
% Tucker  0.1985 worst
%% Main
[ct, m] = HemoFitAnalysis;
% subj x cnr


%% Note: type "doc hungarian" for variable prefix explanation.
