
% LoadPreliminaries;
%
%
%
% Khan 07/19/2011

%% Default params
HemoInit

%% Initialize
% view = getSelectedView;
% mrGlobals
%% Main
% view = selectDataType(view,'Timed'); UpdateView(view);

% Load Spatial Gradient for Inhomogeneity Correction 
view = loadSpatialGradient(view);

pTSeries = fullfile(dataDir(view), 'TSeries', 'Scan1', 'tSeries1.mat');

if exist(pTSeries, 'file')
    % Either load series ...
    viScans = 1:length(mrSESSION.functionals);
    view.tSeries = loadtSeries(view);
% else
    % ... or transform tseries.
%     view = TransformTSeriesIp2Vol(view);
end



%% Note: type "doc hungarian" for variable prefix explanation.
