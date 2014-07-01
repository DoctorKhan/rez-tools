function [p, n] = p2n(p)

% [p, n] = p2n(p);
%
%
%
% Khan 10/18/2011

%% Default params


%% Initialize


%% Main
p(p == 'p') = '.';
p(p == 'n') = '-';

n = str2double(p);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
