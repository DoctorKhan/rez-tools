function [vInd, vbBad] = sub2ind3d(mCoords, viDim)

% vInd = sub2ind3d(mCoords, viDim);
%
% sub2ind3d(mCoords, viDim) also accepted.
% return the 1-d matlab indices (vInd) corresponding to (row, col, set)
% matlab indices specified in a 3xN matrix (mCoords).
%
% Khan 12/09/2009 - Created
% Khan 02/04/2010 - Now does error checking to see if data class restricts
% maximum value to be less than maximum possible index value
% Khan 09/01/2010 - Added capability to remove coordinates outside of viDim


%% Default
Default viDim = GetDimFromAnat;

%% Main
% if isscalar(viDim), viDim = repmat(viDim, 1,3); end
vInd = sub2ind(HorzVec(viDim), mCoords(1,:), mCoords(2,:), mCoords(3,:));
vbBad = false(size(vInd));
return
%% Argument handling
% Accept reverse ordering of arguments
if isvector(mCoords)
    [viDim mCoords] = swap(viDim, mCoords);
end

if isempty(mCoords)
    vInd = [];
    return
end

if isstruct(viDim), viDim = size(viDim.tU); end

%% Argument validation
% Make sure data class allows large enough index values
vSize2 = double(viDim);

if isa(mCoords, 'integer') && intmax(class(mCoords)) < prod(vSize2);
    Alert(['Warning: ' class(mCoords) ' limits maximum index value. Possible truncation.']);
end

%% Main
for ii = 1:3
    mCoords(mCoords(:,ii) > viDim(ii)) = viDim(ii);
end
mCoords(mCoords < 1) = 1;
vInd = sub2ind(viDim, mCoords);

end

%% Note: type "doc hungarian" for variable prefix explanation.
