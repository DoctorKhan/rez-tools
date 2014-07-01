function b = isStructVec(x)

% b = isStructVec(x);
%
%
%
% Khan 01/06/2012
 
%% Default params


%% Initialize


%% Main
b = isvector(x) && isstruct(x) && numel(x) > 1;

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
