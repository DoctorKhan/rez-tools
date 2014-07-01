function tG2 = GradSq5p(t3d)

% tG2 = GradSq5p(t3d);
%
% 5-point laplacian.
%
% Khan 06/07/2012
 
%% Default params
%% Initialize
x=1; y=2; z=3;

%% Main
tGx = Deriv5p(t3d, x);
tGy = Deriv5p(t3d, y);
tGz = Deriv5p(t3d, z);

tGx2 = Deriv5p(tGx, x);
tGy2 = Deriv5p(tGy, y);
tGz2 = Deriv5p(tGz, z);

tG2 = tGx2 + tGy2 + tGz2;

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
