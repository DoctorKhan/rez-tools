function varargout = lrt(varargin)

% varargout = lrt(varargin);
%
%
%
% Khan 06/30/2011

%% Default params

%% Initialize


%% Main
if nargout > 0
	varargout = ll('-rt', varargin{:});
else
	ll('-rt', varargin{:});
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
