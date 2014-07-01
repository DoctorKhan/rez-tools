% function TestLamHRFAll

% TestLamHRFAll;
%
%
%
% Khan 08/17/2011

%% Initialize
HemoInit
cds(voHemo(1));
Default oView
if notDefined('oView')
	oView = InitHidden('Volume', 'Timed', [], oView);
end

%% Main
disp('Calling routine.')
voStriate = voBaseROIs(end-1:end);
oUpper50 = voCNRSet(2);
LamHRFAll(voHemo, voStriate, oUpper50, [], oView, 1200, 'Load');
%LamHRFTransAll(voHemo, V14pu50, voCNRSet(2), oView, 500, 'Load');

%% Note: type "doc hungarian" for variable prefix explanation.
