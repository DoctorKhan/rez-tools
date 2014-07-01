function bIsFile = isFile(varargin)

% bIsFile = isFile(varargin);
%
%
%
% Khan 12/31/2011
 
%% Default params


%% Initialize


%% Main
bIsFile = CellFun(@(x) ischar(x) && exist(x, 'file') && ~isdir(x), varargin);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
