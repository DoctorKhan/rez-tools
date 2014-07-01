function MeanEventsAll(voHemo)
%
%
%
% Khan 07/12/2011

%% Initialize
HemoInit

%% Main
for oHemo = voHemo
	MeanEventsSingle(oHemo.sSession);
end
end
%% Note: type "doc hungarian" for variable prefix explanation.
