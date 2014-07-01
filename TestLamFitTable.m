% TestLamFitTable;
%
%
%
% Khan 09/20/2011

%% Default params


%% Initialize
HemoInit

oHemo = voHemo(1);
cds(oHemo)
%% Main
%%
voFiles = FindHemoFiles(1:5);
LamFitTable(voHemoComb, voFiles);

%% Note: type "doc hungarian" for variable prefix explanation.
