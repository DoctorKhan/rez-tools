function [tData, vMmPerVox, viDim, pAnatFile] = GetVAnat(sSubject)

% [tData, vMmPerVox, viDim, pAnatFile] = GetVAnat(sSubject);
%
%
%
% Khan 06/01/2011

%% Default params
Default sSubject = GetSubject

%% Initialize
sCurDir=pwd;

%% Main
if defined('sSubject')
    % go to subject directory
    [d, sSubject] = cda(sSubject);
end

sAnatFile = [ sSubject, '_FS_Seg.nii.gz' ];

if exist(sAnatFile, 'file')
    oNifti = readFileNifti(sAnatFile);
    tData = double(oNifti.data);
    vMmPerVox = oNifti.pixdim;
    viDim = oNifti.dim;
    pAnatFile = fullfile(pwd, sAnatFile);
else
    [tData, vMmPerVox, viDim, pAnatFile] = readFileVAnat('vAnatomy.dat');
end
    Str(pAnatFile);

cd(sCurDir);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
