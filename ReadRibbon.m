function oRibbon = ReadRibbon(pFileIn)

% oRibbon = ReadRibbon(pFileIn);
%
%
%
% Khan 12/30/2011
 
%% Default params


%% Initialize


%% Main
pFileNifti = TempFile(FileExt(basename(pFileIn), '.nii.gz'));
linux('surf mri_convert', pFileIn, pFileNifti);
oRibbon = readFileNifti(pFileNifti);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
