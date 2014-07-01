function varargout = NiftiTransform(sFile, sOption)

% NiftiTransform(sFile, sOption);
%
% This transforms the dimensions of Freesurfer nifti file to be in accord
% with others.
% if sOption contains "write", file will be written. If it has "reverse"
% then the reverse transform will be applied.
%
% Khan 06/29/2011

%% Default params
if notDefined('sOption'), sOption = ''; end

%% Initialize


%% Main
% In
if ischar(sFile)
    oRibbon = readFileNifti(sFile);
else
    oRibbon = sFile;
end

% Fix Nifti file
switch sOption
	case 'itk2fs'
		tiRibbon = permute(flipdim(flipdim(oRibbon.data, 1), 3), [1 3 2]);
	case 'fs2itk'
		tiRibbon = flipdim(flipdim(permute(oRibbon.data, [1 3 2]), 3), 1);
	case 'itk2vista'
		tiRibbon = flipdim(flipdim(permute(oRibbon.data,[3 2 1]),1), 2);
end
   
oRibbon.data(:) = tiRibbon(:);

if nargout > 0, varargout{1} = oRibbon; end

if regexpi(sOption, 'write')
    % Out
    writeFileNifti(oRibbon);    
end



end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
