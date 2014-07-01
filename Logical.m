function xOut = Logical(xIn)

% xOut = Logical(xIn);
%
% Removes nans and infs first.
%
% Khan 01/03/2012
 
%% Default params


%% Initialize


%% Main
xIn(~isfinite(xIn)) = 0;
xOut = logical(xIn);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
