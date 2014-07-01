function varargout = ll(varargin)

% ll(varargin);
%
% Greene, 09/09 - Fixed
% Khan 01/19/2011 - updated, fixed some bugs.

%% Main
if nargout > 0
	varargout = Ls('-l', varargin{:});
else
	Ls('-l', varargin{:});
end

end

%% Note: type "doc hungarian" for variable prefix explanation.
