function FixLinks(voHemo)

% FixLinks;
%
%
%
% Khan 06/13/2012
 
%% Default params
HemoInit

%% Initialize

%% Main
for oHemo = voHemo
    Destruct oHemo
    pSurfDir1 = AnatPath(oHemo, 'FreeSurfer');
    pSurfDir2 = ExportPath('mri', 'Anatomy', [sSubject 'HR']);
    
    sSubjectHR_FS = [HorzVec(sSubject) 'HR_FS'];
    pFreeSubdir = fullfile(sSubjectHR_FS, 'surf');
    pSurfDir = TryPaths({pSurfDir1, pSurfDir2}, {pFreeSubdir});
    
    pSurfLink = AnatPath(oHemo, 'Surfaces');
    if ~exist(pSurfDir, 'file')
        Str('Warning: Sorry,', pSurfDir, 'does not exist.');
        Str('Cannot make link', pSurfLink, '.');
        continue
    end
    if ~exist(pSurfLink, 'file')
        link(pSurfDir, pSurfLink, '-vfs');
    end
    
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
