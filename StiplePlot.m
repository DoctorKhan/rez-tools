function StiplePlot(vTime, vData, vLowerError, vUpperError, sColor)

% StiplePlot(vTime, vData, vLowerError, vUpperError, sColor);
%
%
%
% Khan 12/27/2010

%% Default params
if notDefined('vUpperError')
    vUpperError = vLowerError;
end

%% Initialize


%% Main
vUpper = vData + vUpperError;
vLower = vData - vLowerError;

plot(vTime, vLower, 'LineStyle', '-', 'Color', sColor, 'MarkerSize', 0.4); hold on;
plot(vTime, vUpper, 'LineStyle', '-', 'Color', sColor, 'MarkerSize', 0.4); 
plot(vTime, vData, 'k', 'Color', sColor, 'LineWidth', 2); 

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
