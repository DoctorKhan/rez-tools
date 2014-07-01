function vOut = HorzVecCat(varargin)

% vOut = HorzVecCat(varargin);
%
%
%
% Khan 04/04/2012
 
%% Default params


%% Initialize


%% Main
c = CellFun(@HorzVec, varargin);
vOut = [c{:}];

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
