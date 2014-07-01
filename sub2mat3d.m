function tMatOut = sub2mat3d(mCoords, vData, viDim)

% tMatOut = sub2mat3d(mCoords, vData, viDim);
%
% Converts a set of subs (coordinates) of a tMatrix into a tMatrix with
% corresponding data vData.
%
% Khan 10/03/2010

%% Argument handling
if notDefined('viDim')
    mVert = VertMat(mCoords);
    viDim = squeeze(ceil(max(mVert)));
end

if ~isvector(viDim)
    viDim = size(viDim);
end

%% Initialize
if any(mCoords(:) < 0.5), mCoords = mCoords + 1; end
mCoords = round(HorzMat(mCoords));
vData = HorzVec(vData);

vbGood = all(isfinite(mCoords));
mCoords = mCoords(:, vbGood);
vData = vData(vbGood);

tMatOut = nan(viDim);

%% Main
viData = sub2ind3d(mCoords, viDim);
tMatOut(viData) = vData;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
