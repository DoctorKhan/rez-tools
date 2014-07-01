function bIs = isNumVector(v)

% bIs = isNumVector(v);
%
%
%
% Khan 01/06/2012
 
%% Default params


%% Initialize


%% Main
bIs = isnumeric(v) && isvector(v) && numel(v) > 1;

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
