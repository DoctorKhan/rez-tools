function SliceMesh(voMesh, iDim, iSlice, sliceWidth, vScale, vOrigin, varargin)

% SliceMesh(oMesh, tVolume, iDim, iSlice, sliceWidth, vScale, vOrigin, varargin);
%
% iDim = 1, 2, 3 (x, y, z)
%
% Khan 06/01/2011

%% Default params
Default sliceWidth = 0.5 & iDim = 1;
Default sStyle = ".";
Default vScale = [1 1 1];
Default vOrigin = [0 0 0];

%% Arg handling
if notDefined('iSlice')
    vCenter = nanmean(voMesh(1).vertices,2);
    iSlice = ceil(vCenter(iDim));
end

%% Init
Default nPoints = 2000;

for oMesh = voMesh
    oRaw = RawMesh(oMesh);
    
    %% Main
    oRaw.UnitsOff;
    mCoords = oRaw.vertices;
    
    mCoords = MatrixVectorSum(mCoords, vOrigin);
    mCoords = MatrixVectorProd(mCoords, vScale);
    
    vCoords = mCoords(iDim,:);
    sliceWidth = fminsearch(@(x) abs(sum(abs(vCoords - iSlice) < x/2) - nPoints), sliceWidth);
    vbSlice = abs(vCoords - iSlice) < sliceWidth/2;
    
    Str(sum(vbSlice), 'mesh points in slice.');
    
    [x y z] = Foliate(mCoords(:, vbSlice));
%     try
        vColor = oRaw.mColors(:,1);
%     catch
%         vColor = 'b';
%     end
    
    Default sMarker = "."
    switch iDim
        case 1
            plot(z, y, sMarker, 'color', vColor, varargin{:});
        case 2
            plot(z, x, sMarker, 'color', vColor, varargin{:});
        case 3
            plot(y, x,  sMarker, 'color', vColor, varargin{:});
        otherwise
    end
    axis image; hold on
    viDim = diff(BoundingBox(oMesh));
    title(Str('Dim:', iDim, 'Slice:', iSlice, '/', viDim(iDim)));
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
