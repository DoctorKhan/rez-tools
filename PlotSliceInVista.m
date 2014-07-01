function oView = PlotSliceInVista(oView, xData, iSlice, iDim, sliceWidth)

% PlotSliceInVista(oMesh, tVolume, iSlice, iDim, sliceWidth);
%
% iDim = 1, 2, 3 (x, y, z)
%
% Khan 06/01/2011

%% Init
tVolume = oView.anat;
Default iSlice = getCurSlice(oView);
Default iDim = getCurSliceOri(oView);

%% Default params
Default sliceWidth = 5;

%% Main
if ~isstruct(xData)
    oMesh.vertices = xData;
    oMesh.mmPerVox = 1;
else
    oMesh = xData;
end

if ~isfield(oMesh, 'fov'), oMesh.fov = size(tVolume).*oMesh.mmPerVox; end

mCoords = phys2mat(oMesh, oMesh.fov); % centered coordinates
vbSlice = abs(mCoords(iDim,:) - iSlice) < sliceWidth/2;

% tVolume = permute(tVolume, circshift([3 1 2]', -1*iDim));
% mImage = tVolume(iSlice, : , :);
colormap gray
[x y z] = Foliate(mCoords(:,vbSlice)*.1);
switch iDim
    case 1
       PlotPointsOnImage(mCoords(2, vbSlice), mCoords(3, vbSlice));

    case 2
       PlotPointsOnImage(mCoords(3, vbSlice), mCoords(1, vbSlice));

    case 3
       PlotPointsOnImage(mCoords(1, vbSlice), mCoords(2, vbSlice));
    otherwise
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
