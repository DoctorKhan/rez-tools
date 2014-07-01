function oMesh = ReadFreeSurf(pFileIn, mmPerVox, viDim)

% ReadFreeSurf(pInFile);
%
% Read FreeSurfer surface file.
%
% Khan 04/24/2012

%% Default params
oHeader = mris_info(pFileIn);
oHemo = HemoFromDir(pFileIn);
Default mmPerVox = GetVoxelSize(oHemo);

%% Initialize
if numel(mmPerVox) == 1; mmPerVox = repmat(mmPerVox, 1, 3); end
try
    Default viDim = oHeader.extent;
catch
    viDim = GetDimFromAnat(oHemo);
end
try
fov = viDim.*mmPerVox;
catch
    keyboard
end

%% Main
oDims = Struct(fov, mmPerVox);
oMesh = ReadObjIntoMesh(surf2obj(pFileIn), oDims);
oMesh.header = oHeader;

% vertices = oMesh.vertices;
oMesh.vertices = oMesh.vertices([2 3 1],:) .* [-1 -1 1]';

oMesh.mmPerVox = mmPerVox;
oMesh.filename = FileExt(pFileIn, '.raw', 'weakly');


end % Function

%     msInfo = linux('surf mris_info', pFile);
%     csLines = str2cell(msInfo)';
%     [~, csLine] = CellMatch(csLines, 'voxel');
%     sLine = regexprep(csLine{1}, {'voxel *', ':', '(', ')'}, {'mmPerVox', ' =', '[', '];'});
%     eval(sLine);

%% Note: type "doc hungarian" for variable prefix explanation.
