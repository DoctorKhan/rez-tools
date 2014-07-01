function [tPlaidX tPlaidY tPlaidZ tX tY tZ] = Plaid(tIn, lambda)

% [tPlaidX tY tZ] = Plaid(tIn, lambda);
%
%
%
% Khan 02/06/2012
 
%% Default params


%% Initialize
k=2*pi/lambda;

%% Main
[tX tY tZ] = CartesianCoords(tIn);

tPlaidX = sin(k*tX);
tPlaidY = sin(k*tY);
tPlaidZ = sin(k*tZ);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
