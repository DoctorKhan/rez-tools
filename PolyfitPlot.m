function p = PolyfitPlot(x, y, n)

%
% p = PlotFit(x, y, n);
%
% 
%
% Khan 11/01/09
%

p = polyfit(x, y, n);
f = polyval(p, x);
plot(x, y, '.')
hold on
plot(x, f, 'r+')
