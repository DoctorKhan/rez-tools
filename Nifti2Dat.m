function pDat = Nifti2Dat(pNifti, pDat)

% pDat = Nifti2Dat(pNifti, pDat);
%
% Convert a Nifti to a Dat file.
%
% Khan 06/28/2011

%% Default params
Default pNifti = UIGetFile('*.nii*')
if notDefined('pNifti'), return; end

Default pDat = FileExt(pNifti, 'dat', 'greedy')

%% Main
oNifti = readFileNifti(pNifti);

writeVolAnat(uint8(oNifti.data), oNifti.pixdim, pDat);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
