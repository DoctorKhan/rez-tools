function [vY, vT] = SampleHRF(iType)

% SampleHRF;
%
%
%
% Khan 09/23/2011

%% Default params
Default iType = 1

%% Initialize


%% Main

% No initial dip
vT = 0:.1:25;
A = 1; t0 = 2; f = .1; tau = 5;
y{1} = DampedSinusoid(A, f, tau, t0, vT);

% Inital dip
dip = - .2*A*sin(pi*vT/t0);
dip(vT > t0) = 0;
y{2} = y{1} + dip;

% Initial monotonic increase
t0 = 0;
y{3} = DampedSinusoid(A, f, tau, t0, vT);

%% Output
vY = y{iType};

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
