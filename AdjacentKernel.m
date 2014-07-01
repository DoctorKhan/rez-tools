function t = AdjacentKernel

% t = AdjacentKernel;
%
%
%
% Khan 04/17/2010

%% Default params


%% Initialize


%% Main
t = false(3, 3, 3);
t(2,2,2) = true;
t(2, 2, 1) = true;
t(2, 1, 2) = true;
t(2, 3, 2) = true;
t(1, 2, 2) = true;
t(3, 2, 2) = true;
t(2, 2, 3) = true;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
