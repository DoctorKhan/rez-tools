% TestMinima;
%
%
%
% Khan 09/23/2011

%% Default params


%% Initialize


%% Main
[vY, vT] = SampleHRF(3);
PlotWithMarkers(vT, vY, Minima(vY));

%% Note: type "doc hungarian" for variable prefix explanation.
