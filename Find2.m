function vFound = Find2(varargin)

% vFound = Find2(varargin);
%
%
%
% Khan 01/04/2012
 
%% Default params


%% Initialize


%% Main
vFound = find(varargin{:});
if isempty(vFound)
	vFound = 0;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
