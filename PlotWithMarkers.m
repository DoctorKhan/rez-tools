function h = PlotWithMarkers(vT, vY, viMarkers)

% h = PlotWithMarkers(vT, vY, viMarkers);
%
%
%
% Khan 09/23/2011

%% Default params


%% Initialize


%% Main
vY2 = vY(viMarkers);
vT2 = vT(viMarkers);

plot(vT, vY); hold on;
xlim([min(vT), max(vT)]);
h = plot(vT2, vY2, 'ro');


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
