function FixRawMeshOrientation(pFilename, mmPerVox)

% FixRawMeshOrientation(pFilename, mmPerVox);
%
%
%
% Khan 09/13/2010

%% Default params
if notDefined('mmPerVox'), mmPerVox = 1; end

%% Initialize
[p, pBasename] = fileparts(pFilename);

%% Main
oMesh = ReadRawFileIntoMesh(pFilename);
mVerts = oMesh.vertices*mmPerVox;
mVerts = [mVerts(2,:); mVerts(1,:); mVerts(3,:)];

oMesh.vertices = mVerts;

SaveMeshRaw(oMesh, [pBasename, 'Fixed.raw']);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
