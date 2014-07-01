function bIsLong = isLongVector(v)

% isLongVector;
%
%
%
% Khan 09/07/2011

%% Default params


%% Initialize


%% Main
bIsLong = isvector(v) && numel(v) > 1;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
