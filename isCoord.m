function b = isCoord(x)

% b = isCoord(x);
%
%
%
% Khan 04/26/2012
 
%% Default params


%% Initialize
viDim = size(x);

%% Main
b = length(viDim) == 2 && any(viDim == 3);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
