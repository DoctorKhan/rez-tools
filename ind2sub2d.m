function mSubs = ind2sub2d(viIndices, viDim)

% mSubs = ind2sub2d(viIndices, viDim);
%
%
%
% Khan 10/13/2010

%% Default params


%% Initialize


%% Main
[vI,vJ] = ind2sub(viDim, viIndices);

mSubs = [HorzVec(vI); HorzVec(vJ)];

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
