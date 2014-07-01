function varargout = St(varargin)

% sString = St(varargin);
%
% Concatenates various types into string.
%
% Khan 07/31/2011

%% Arg handling
% Passed cell of strings, rather than single set, so process each one.

%% Validation
if nargin == 0
	varargout = cell(1, nargout);
	return
end

%% Initialize
sString = Str(varargin{:},'');

%% Output
if nargout > 0
	varargout{:} = sString;
else
	disp(sString);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
