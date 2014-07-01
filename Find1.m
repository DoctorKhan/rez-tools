function iFound = Find1(varargin)

% iFound = Find1(varargin);
%
%
%
% Khan 01/04/2012
 
%% Default params


%% Initialize


%% Main
iFound = find(varargin{:}, 1, 'first');
if isempty(iFound), iFound = 0; end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
