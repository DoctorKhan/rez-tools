function nCoords = len3(mCoords)

% nCoords = len3(mCoords);
%
% Number of coordinates in 3xN matrix. length() gives 3 when matrix is 3x2.
% len3 gives 2.
%
% Khan 04/23/2012
 
%% Default params


%% Initialize


%% Main
v = size(mCoords);
nCoords = max(v(v~=3));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
