function [minV, maxV] = Bounds(v)

% Bounds;
%
%
%
% Khan 01/22/2012
 
%% Default params


%% Initialize


%% Main
vMinMax = minmax(v);
minV = vMinMax(1);
maxV = vMinMax(2);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
