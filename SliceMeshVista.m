function oView = SliceMeshVista(oView, sliceThick, viMesh)

% oView = SliceMeshVista(oView, sliceThick, viMesh);
%
%
%
% Khan 06/02/2012

%% Default params
global selectedVOLUME
global VOLUME
Default oView = VOLUME{1};
if ~isfield(oView, 'mesh'), return, end

if isfield(oView.ui, 'meshOverlay')
  % meshOverlay is expected to contain the following fields:
  % sliceThick
    Destruct(oView.ui.meshOverlay, 'weakly');
end

Default sliceThick = 0.5;

%% Initialize
oUI = oView.ui;
nMeshes = length(oView.mesh); % number of meshes to show
Default viMesh = 1:nMeshes;

vbOri = false(1,3);
viSlice = zeros(1,3);

for ii = 1:3
    vbOri(ii) = logical(get(oUI.sliceOriButtons(ii), 'value'));
    viSlice(ii) = str2double(get(oUI.sliceNumFields(ii), 'String'));
end

iOri = find(vbOri);
iSlice = viSlice(vbOri);

switch iOri
    case 1, vi = [3 2];
    case 2, vi = [3 1];
    case 3, vi = [2 1];
end
c = cell(1, 2*nMeshes);

%% Main
for iM = 1:nMeshes
    iMesh = viMesh(iM);
    mVerts = oView.mesh{iMesh}.vertices([2 1 3],:);
    mVerts = MixedMult(mVerts, 1./oView.mmPerVox);
    
    vbInSlice = abs(mVerts(vbOri,:)-iSlice) < sliceThick;

    c{3*iM-2} = VertVec(mVerts(vi(1),vbInSlice));
    c{3*iM-1} = VertVec(mVerts(vi(2),vbInSlice));
    c{3*iM} = 'ro';
end

hold on; plot(c{:}, 'MarkerSize', 2, 'MarkerFaceColor', 'r');

oView.ui.meshOverlay.sliceThick = sliceThick;
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
