function [n, sn] = n2p(n)

% n2p;
%
% Convert numeric characters to letters.
% e.g. -3.4 becomes n3p4.
%
% Khan 09/28/2011

%% Default params


%% Argument handling
if isnumeric(n)
	n = num2str(n);
end

sn = n;

%% Main
n(n == '.') = 'p';
n(n == '-') = 'n';

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
