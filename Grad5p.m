function [tGx, tGy, tGz, tGn] = Grad5p(t3d, varargin)

% [tGx, tGy, tGz, tGn] = Grad5p(t3d);
%
% Grad5pient with 5-point stencil.
%
% Khan 05/20/2012

%% Default params

%% Initialize
x=1; y=2; z=3;

%% Main
tGx = Deriv5p(t3d, x);
tGy = Deriv5p(t3d, y);
tGz = Deriv5p(t3d, z);

tGn = sqrt(tGx.^2 + tGy.^2 + tGz.^2);

if Option('norm')
    tGx = tGx./tGn; 
    tGy = tGy./tGn;
    tGz = tGz./tGn;
end

% t4g = cat(4, tGx, tGy, tGz);

if nargout == 1
        tGx = tGn;
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
