function mCoords =  Sub2Box(mGrid, mBox, vScale)

% mCoords =  Sub2Box(mGrid, Limits);
%
%
%
% Khan 04/27/2012
 
%% Default params
Default vScale = [1 1 1];

%% Initialize


%% Main
mScaled = MatrixVectorProd(mGrid - 1, vScale);
mCoords = MatrixVectorSum(mScaled, mBox(1,:));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
