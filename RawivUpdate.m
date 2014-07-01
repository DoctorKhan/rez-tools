function oRawiv = RawivUpdate(oRawiv)

% RawivUpdate(oRawiv);
%
%
%
% Khan 04/04/2012

%% Initialize
% [mBox vOrigin vUpperLim vScale tData] = 

%% Default params
% Default mBox(1,:) = [0 0 0];
Destruct(oRawiv);

%% Main
try
viDim = size(oRawiv.tData);
catch
    viDim = GetDimFromAnat;
end

if notDefined('mBox')
    mBox = [1 1 1; viDim];
end

% Limits
vExtent = diff(mBox);
vScale = vExtent./(viDim-1);

% Header
nVoxels = int32(prod(viDim));
nGridPts = int32(prod(viDim-1));
mBoxMax = int16([0 0 0; viDim]);
vMinMax = single(minmax(tData));
oHeader = Struct(nVoxels, nGridPts, mBoxMax, vMinMax);

oNew = Struct(tData, viDim, oHeader, mBox, vScale);
oRawiv = CopyStruct(oRawiv, oNew);

Default oHeader.mystery = int32(-1163018513);


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
