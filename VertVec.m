function varargout = VertVec(varargin)

% VertVec;
%
%
%
% Khan 08/15/2011

%% Default params


%% Initialize


%% Main
for iArg = 1:nargin
	varargout{iArg} = reshape(varargin{iArg}, [], 1);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
