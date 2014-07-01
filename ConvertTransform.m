function varargout = ConvertTransform(pFileIn, sOption, pFileOut)

% varargout = ConvertTransform(pFileIn, sOption, pFileOut);
%
% This transforms the dimensions of Freesurfer nifti file to be in accord
% with others.
% if sOption contains "write", file will be written. If it has "reverse"
% then the reverse transform will be applied.
%
% Khan 06/29/2011

%% Default params
if notDefined('sOption'), sOption = ''; end
if nargout == 0, sOption = [sOption, ' write']; end

%% Input
if ischar(pFileIn)
	if ~isempty(regexpi(pFileIn, '.nii'))
		oRibbon = readFileNifti(pFileIn);
	end
	if ~isempty(regexpi(pFileIn, '.obj'))
		oMesh = ReadObjIntoMesh(pFileIn);
	end
else
	oRibbon = pFileIn;
end

%% Dat files
if regexpi(sOption, 'anat2dat')
	if notDefined('pFileOut'), pFileOut = 'vAnatomy.dat'; end
	tu8Ribbon = uint8(oNifti.data);
	writeVolAnat(tu8Ribbon, oNifti.pixdim, pFileOut);
	return
end

if regexpi(sOption, 'itk2dat')
	oRibbon = ConvertTransform(oRibbon, 'itk2anat');
	varargout = ConvertTransform(oRibbon, sOption, pFileOut);
	return
end

%% surf files
if regexpi(sOption, 'surf2vista')
    % See ReadFreeSurf
    a = linux('surf mris_info', pFileIn);
    c = str2cell(a)';
    [~, b] = CellMatch(c, 'voxel');
    d = regexprep(b{1}, {'voxel *', ':', '(', ')'}, {'mmPerVox', ' =', '[', '];'});
    eval(d);
    
	o.mmPerVox = mmPerVox;
    viDim = GetDimFromAnat;
	o.fov = viDim.*o.mmPerVox;
	
    pRaw = linux('surf2raw', pFileIn);
	oMesh = ReadFileIntoMesh(pRaw, o);
	
    o = oMesh;
	oMesh.vertices(1,:) = -o.vertices(2,:);
	oMesh.vertices(2,:) = -o.vertices(3,:);
	oMesh.vertices(3,:) =  o.vertices(1,:);
	
	oMesh = FovOrigin(oMesh, -1);
% 	oMesh.Save;
% 	if defined('pFileOut')
% 		SaveMeshVista(oMesh, pFileOut);
% 		SaveMeshObj(oMesh, FileExt(pFileOut, '.obj'));
% 	else
% 		SaveMeshVista(oMesh, FileExt(pFileIn, '.mat'));
% 		SaveMeshObj(oMesh, FileExt(pFileIn, '.obj'));
% 	end

	if nargout > 0
		varargout{1} = oMesh;
	end
	
	return
end
%% Other files
if notDefined('pFileOut'), pFileOut = pFileIn; end
tiRibbon = oRibbon.data;

if regexpi(sOption, 'fs2itk')
	tiRibbon = flipdim(flipdim(permute(oRibbon.data, [1 3 2]), 3), 1);
end
if regexpi(sOption, 'itk2anat')
	tiRibbon = flipdim(flipdim(permute(oRibbon.data,[3 2 1]),1), 2);
end
if regexpi(sOption, 'itk2class')
	tiRibbon = flipdim(flipdim(permute(oRibbon.data,[2 3 1]),1), 2);
end

if regexpi(sOption, 'fs2class')
	tiRibbon = flipdim(flipdim(permute(oRibbon.data, [3 2 1]), 2), 3);
end

if regexpi(sOption, 'class2itk')
	tiRibbon = permute(flipdim(flipdim(oRibbon.data,1), 2), [3 1 2]);
end

if regexpi(sOption, 'itk2fs')
	tiRibbon = permute(flipdim(flipdim(oRibbon.data, 1), 3), [1 3 2]);
end

oRibbon.data(:) = tiRibbon(:);

%% Coord transforms
switch lower(sOption)
	case 'vol2gray'
		bView = isstruct(pFileIn);
		
		if bView
			oView = pFileIn;
			map = oView.map;
            oHemo = oView.sessionCode;
		else
			map = pFileIn;
		end
		
		[~, bviVol2Gray] = intersect(VolumeIndices(oHemo), GrayIndices);
			
		cvMap= cellfun(@(x) x(:, bviVol2Gray), map);
		
		if bView
			varargout{1} = setParameterMap(oView, cvMap, 'thickMap', 'mm');
		else
			varargout{1} = map;
		end
end


%% Output

if defined('pFileOut'), oRibbon.fname = pFileOut; end

% Save to same file
if regexpi(sOption, 'write')
	if regexpi(pFileOut, '.nii'), writeFileNifti(oRibbon); end
	if regexpi(pFileOut, '.class'), writeClassFile(oRibbon); end
end

if nargout > 0, varargout{1} = oRibbon; end
if nargout > 1, varargout{2} = pFileOut; end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
