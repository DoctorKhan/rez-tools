function t = PermSet(varargin)

% PermSet;
%
% Each argument is a matrix, where combinations are over rows.
% All possible combinations, preserving order, from each set.
% Work in progress
%
% Khan 09/16/2011

%% Default params


%% Initialize


%% Main
t = varargin{1};

for ii = 2:nargin
	t = tensorprod(t, varargin{ii});
end


end % Function

function mOut = tensorprod(m1, m2)
	m1b = repmat(m1, [1 1 rows(m2)]);
	m1c = reshape(permute(m1b, [3 1 2]), rows(m2)*rows(m1), []);

	m2b = repmat(m2,rows(m1), 1);
	mOut = [m1c, m2b];
end	


%% Note: type "doc hungarian" for variable prefix explanation.

