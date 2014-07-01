function plots(x1, x2, varargin)

% plots(fhY, x1, x2);
%
% 1. Simple plot of (function handle) fhY(x) from x1 to x2.
% 2. or plot a vector or matrix with legend
%
% Khan 11/06/09
% Khan 03/08/2010 - Added ability to handle matrix input

Default x2
if ~isnumeric(x2), varargin = [x2 varargin]; x2 = ''; end


if notDefined(x2)
    if isvector(x1) || isvector(squeeze(x1))
        vY = squeeze(x1);
        x = 1:length(vY);
        figure; plot(x, vY, varargin{:});
    else
        m = x1;
        x = m(1,:);
        figure; plot(m, varargin{:});
        legend(regexpi(num2str(1:size(m,2)), '  ', 'split'))
    end
else
    if is3d(x1)
        plots(squeeze(mean(x1, x2)), varargin{:});
    else
        x = x1:0.001*(x2-x1):x2;
        figure; plot(x, x1, varargin{:});
    end
end
try
    xlim([min(x), max(x)]);
end

%% Note: type "doc hungarian" for variable prefix explanation.
