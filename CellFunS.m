function cOut = CellFunS(varargin)

% cOut = CellFunS(varargin);
%
%
%
% Khan 11/15/2011

%% Default params


%% Initialize


%% Main
try
	cOut = cellfun(varargin{:});
catch
	cOut = cellfun(varargin{:}, 'UniformOutput', false);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
