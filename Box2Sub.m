function mGrid = Box2Sub(mCoords, mBox, vScale)

% mGrid = Box2Sub(mCoords, Limits);
%
%
%
% Khan 04/27/2012
 
%% Default params
Default vScale = [1 1 1];

%% Initialize


%% Main
mShifted = mCoords - mBox(1,:);
mGrid = mShifted./vScale + 1;

end % Function

 
%% Note: type "doc hungarian" for variable prefimCoords emCoordsplanation.
 
%% Note: type "doc hungarian" for variable prefix explanation.
