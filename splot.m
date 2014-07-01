function splot(fhY, x1, x2)

% splot(fhY, x1, x2);
%
% 1. Simple plot of (function handle) fhY(x) from x1 to x2.
% 2. or plot a vector or matrix with legend
%
% Khan 11/06/09
% Khan 03/08/2010 - Added ability to handle matrix input

switch nargin
    case 1
        if isvector(fhY) || isvector(squeeze(fhY))
            vY = squeeze(fhY);
			x=1:length(vY);
            figure; plot(x, vY);
        elseif ismatrix(fhY)
			m = fhY;
			x = m(1,:);
            figure; plot(m);
            legend(regexpi(num2str(1:size(m,2)), '  ', 'split'))
        end
    case 2
        if istmatrix(fhY)
            splot(squeeze(mean(fhY, x1)));
			return
        end
    otherwise
        x = x1:0.001*(x2-x1):x2;
        figure; plot(x, fhY(x));
end
try
	xlim([min(x), max(x)]);
catch
end
end

%% Note: type "doc hungarian" for variable prefix explanation.
