function [g, gx, gy, gz] = SplineGrad(t)

% SplineGrad;
%
% Cubic spline gradient
%
% Khan 06/01/2012
 
%% Default params
%% Initialize
g = zeros([size(t) 3]);

%% Main
for iDim = 1:3
    g(:,:,:,iDim) = SplineDer(t, iDim);
end

if nargout > 1
    [gx gy gz] = Foliate(g);
    g = Mag(g,4);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
