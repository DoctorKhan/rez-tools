function varargout = GetFields(oStruct, varargin)

% varargout = GetFields(oStruct, varargin);
%
%
%
% Khan 08/16/2011

%% Default params


%% Initialize


%% Main
nArgs = nargin - 1;

for iArg = 1:nArgs
	try
		varargout{iArg} = getfield(oStruct, varargin{iArg});
	catch
		varargout{iArg} = [];
	end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
