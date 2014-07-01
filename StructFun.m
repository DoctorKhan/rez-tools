function oOut = StructFun(varargin)

% oOut = StructFun(varargin);
%
%
%
% Khan 01/03/2012
 
%% Default params


%% Initialize


%% Main
try
	oOut = structfun(varargin{:});
catch
	oOut = structfun(varargin{:}, 'UniformOutput', false);
end


end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
