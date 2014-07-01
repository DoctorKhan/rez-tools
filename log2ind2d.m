function viInds = log2ind2d(mMask)

% viInds = log2ind2d(mMask);
%
%
%
% Khan 10/18/2010

%% Default params


%% Initialize


%% Main
[mCoords, viDim] = log2sub2d(mMask);
viInds = sub2ind(viDim, mCoords(1,:), mCoords(2,:));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
