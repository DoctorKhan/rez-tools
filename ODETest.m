% Consider the following ODE, with time-dependent parameters defined only through the set of data points given in two vectors: 
% y'(t) + f(t)y(t) = g(t)

% The initial condition is y(0) = 0, where the function f(t) is defined through the n-by-1 vectors tf and f, and the function g(t) is defined through the m-by-1 vectors tg and g.

% First, define the time-dependent parameters f(t) and g(t) as the following: 
ft = linspace(0,5,25); % Generate t for f
f = ft.^2 - ft - 3; % Generate f(t)
gt = linspace(1,6,25); % Generate t for g
g = 3*sin(gt-0.25); % Generate g(t)

% Call the derivative function myode.m within the MATLAB ode45 function specifying time as the first input argument :
TSPAN = [1 5]; % Solve from t=1 to t=5
IC = 1; % y(t=0) = 1
[T Y] = ode45(@(t,y) myode(t,y,ft,f,gt,g),TSPAN,IC); % Solve ODE

% Plot the solution y(t) as a function of time: 
plot(T, Y);
title('Plot of y as a function of time');
xlabel('Time'); ylabel('Y(t)');