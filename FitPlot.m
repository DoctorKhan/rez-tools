function FitPlot(vX, vY, vLower, vUpper, vXFit, vYFit, errorbarWidth, sColor, sStyle)

% FitPlot(vX, vY, vLower, vUpper, vXFit, vYFit, errorbarWidth, sColor);
%
% 
%
% Khan 05/12/2010

%% Default params
Default errorbarWidth = 0.05; % width
Default sColor = [0 0 .5];

%% Initialize


%% Main

% Create Basic Plot

set(gcf, 'Units', 'pixels', ...
    'Position', [100 100 500 375]);
hold on;

hFitLine   = line(vXFit  , vYFit, 'LineStyle', sStyle   );
hErrorBar     = errorbar(vX, vY, vY - vLower, vUpper - vY);

% Adjust Line Properties (Esthetics)
set(hFitLine, ...
  'Color'           , sColor, ...
  'LineWidth'       , 2 );
set(hErrorBar, ...
  'Color'           , [.3 .3 .3], ...
  'LineStyle'       , 'none'      , ...
  'LineWidth'       , 1           , ...
  'Marker'          , 'd'         , ...
  'MarkerSize'      , 8           , ...
  'MarkerEdgeColor' , [.2 .2 .2]  , ...
  'MarkerFaceColor' , [.7 .7 .7]  );

% adjust error bar width
hErrorBarChildren = get(hErrorBar, 'Children' );

vErrorBarXData = get(hErrorBarChildren(2), 'XData' ); % Get width data

% Adjust width
vErrorBarXData(4:9:end) = vErrorBarXData(1:9:end) - errorbarWidth; % Top left
vErrorBarXData(7:9:end) = vErrorBarXData(1:9:end) - errorbarWidth; % Bottom left

vErrorBarXData(5:9:end) = vErrorBarXData(1:9:end) + errorbarWidth; % Top Right
vErrorBarXData(8:9:end) = vErrorBarXData(1:9:end) + errorbarWidth; % Bottom Right

% update widths
set(hErrorBarChildren(2), 'XData', vErrorBarXData);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
