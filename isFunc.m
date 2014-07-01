function vbOut = isFunc(varargin)

% vbOut = isFunc(varargin);
%
% Returns boolean vector identifying function handles passed.
%
% Khan 12/27/2011
 
%% Default params


%% Initialize


%% Main
vbOut = CellFun(@(x) isa(x, 'function_handle'), varargin);

for ii = 1:nargin
    vbOut(ii) = vbOut(ii) && ~isempty(which(func2str(varargin{ii})));
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
