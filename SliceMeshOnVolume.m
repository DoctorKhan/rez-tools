function varargout = SliceMeshOnVolume(oRawMesh, oRawiv, iDim, iSlice, sliceWidth, vScale, vOffset, varargin)

% SliceMeshOnVolume(oRawMesh, oRawiv, iDim, iSlice, sliceWidth, vScale, vOffset, varargin);
%
% iDim = 1, 2, 3 (x, y, z)
%
% Khan 06/01/2011

%% Init
if ~isMesh(oRawMesh) && isMesh(oRawiv)
    [oRawiv oRawMesh] = swap(oRawiv, oRawMesh);
end

oRaw = RawMesh(oRawMesh);

oRawiv = Rawiv(oRawiv);
% oRawiv = oRawiv.InterpFull;

%% Default params
Default sliceWidth = 0.5 & iDim = 1;
Default sStyle = ".";
Default vScale = [1 1 1];

%% Arg handling
if isa(oRawiv, 'Seg'), tData = oRawiv.Gray; end

if isRawiv(oRawiv),
    Default oRawiv.mBox(:) = 1;
    [tData, mBox, vScale] = Destruct(oRawiv, 'tData', 'mBox', 'vScale');
    vScale = 1./vScale;
    vOffset = -mBox(1,:) + 1;
end

if notDefined('iSlice')
    try 
        vertices = oRaw.vertices; 
    catch
        vertices = oRaw;
    end
    mBoxG = round(nanmean(vertices,2));
    iSlice = ceil(mBoxG(iDim)/2);
end

%% Main
Default vScale = [1 1 1];
Default vOffset = [1 1 1].*vScale;
mUnshifted = oRaw.vertices;
mCoords = mUnshifted.*vScale + vOffset;

for sliceWidth = (1:10)*sliceWidth
    vbSlice = abs(mCoords(iDim,:) - iSlice) < sliceWidth/2;
    nPts = total(vbSlice);
    if frac(vbSlice) > 0.1 || nPts > 1000
        break;
    end
    Str('Only', nPts, 'points. Increased slice-width to', sliceWidth);
end

if nargout == 0
    Str(sum(vbSlice), 'mesh points in slice.');
end

viDim = size(tData);

try
if notDefined('oRaw.normals'), oRaw.NormSurf; end
end

switch(iDim)
    case 1
        viSlice = [3 2];
    case 2
        viSlice = [1 3];
    case 3
        viSlice = [2 1];
end
% Destruct(oRaw);

Default oRaw.vbLanded = true(size(vbSlice));
Default oRaw.vbNewFailure = false(size(vbSlice));
Default oRaw.vbOldFailure = false(size(vbSlice));

viPerm = circshift([1 2 3], [0 (1-iDim)]);
tDataPerm = permute(tData, viPerm);
mImage = tDataPerm(iSlice, : , :);
if islogical(mImage), mImage = double(mImage) - 0.5; end

vbGreen = vbSlice & HorzVec(oRaw.vbLanded);
vbYellow = vbSlice & HorzVec(oRaw.vbNewFailure);
vbRed = vbSlice & HorzVec(oRaw.vbOldFailure);

if any(vbGreen)
    cVertG = Foliate(mCoords(viSlice, vbGreen), 'cell');
    cNormG = Foliate(oRaw.normals(viSlice, vbGreen), 'cell');
    PlotPointsOnImage(cVertG{:}, mImage, 'g.', varargin{:}); hold on;
    if Option('vector'), quiver(cVertG{:}, cNormG{:}, 'g'); end
end
if any(vbRed)
    cVertR = Foliate(mCoords(viSlice, vbRed), 'cell');
    cNormR = Foliate(oRaw.normals(viSlice, vbRed), 'cell');
    plot(cVertR{:}, 'ro', varargin{:}); hold on;
    if Option('vector'), quiver(cVertR{:}, cNormR{:}, 'r');end
end
if any(vbYellow)
    cVertY = Foliate(mCoords(viSlice, vbYellow), 'cell');
    cNormY = Foliate(oRaw.normals(viSlice, vbYellow), 'cell');
    plot(cVertY{:},'co', varargin{:}); hold on;
    if Option('vector'), quiver(cVertY{:}, cNormY{:}, 'c'); end
end

% mBoxG = BoundingBox(oRaw.vertices);
% vCenter = mean(mBoxG);
% mCent = [vCenter;vCenter];

% zoomFac = 1.1;
% mBoxG = (mBoxG - mCent)/zoomFac + mCent;
% axis(mBoxG(:, viSlice));

title(Str('Dim:', iDim, 'Slice:', iSlice, '/', viDim(iDim)));
colormap jet

if nargout > 0
    varargout{1} = iSlice;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
