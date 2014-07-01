function tb = sub2log3d(miSubs, viDim)

% tb = sub2log3d(miSubs, viDim);
%
% Convert matlab subscripted indices to logical tMatrix.
%
% Khan 03/16/2010

%% Default params
Default viDim = GetDimFromAnat;
if is3d(viDim), viDim = size(viDim); end
if isscalar(viDim), viDim = repmat(viDim, 1, 3); end    

%% Initialize
miSubs(:,any(miSubs == 0)) = [];
miSubs = round(reshape(miSubs, 3, []));
viDim = HorzVec(viDim);

%% Main
viSubs = sub2ind3d(miSubs, viDim);
tb = false(viDim);
tb(viSubs(isfinite(viSubs))) = true;
% tb = ind2log3d(Finite(viSubs), viDim);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
