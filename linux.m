function varargout = linux(varargin)

% [sOut, iStatus] = linux(varargin);
%
% Calls unix command, but reverses output argument order
%
% Khan 11/19/2009

%% Validation
% if ~isunix, error('linux command requires unix system'); end

%% Main
for iArg = 1:nargin
s = varargin{iArg};
if ischar(s) && ~isempty(regexp(s, ' ', 'once')) && exist(s, 'file') && ...
~isempty(regexp(s, '(|)| ', 'once'))
varargin{iArg} = dquote(s);
end
end

if nargout == 0 || ~isempty(cellfind(varargin, '-echo'))
varargin(cellfind(varargin, '-echo')) = [];
[iStatus, sOut] = unix(Str(varargin{:}), '-echo');
else
[iStatus, sOut] = unix(Str(varargin{:}));
end

%% Output
sOut = strtrim(sOut);

if isNumStr(sOut), sOut = str2double(sOut); end

if nargout > 0, varargout{1} = sOut; end
if nargout > 1, varargout{2} = iStatus; end
if nargout > 2, varargout{3} = str2double(sOut); end

end %function
%% Note: type "doc hungarian" for variable prefix explanation.
