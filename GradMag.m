function [g, med] = GradMag(tField)

% [g, med] = GradMag(tField);
%
% magnitude of gradient
%
% Khan 04/29/2012

%% Default params


%% Initialize


%% Main
g = Grad5p(tField);
if nargout > 1, med = NanMedian(g); end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
