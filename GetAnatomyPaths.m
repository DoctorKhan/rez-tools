function [pGrayLeft, pGrayRight, pInner, pOuter, pInnerRef, pOuterRef, pClassLeft, pClassRight] = GetAnatomyPaths(sSubject, sRegion, sType, sHemisphere, sSubfield)

% [pGrayLeft, pGrayRight, pInner, pOuter, pInnerRef, pOuterRef, pClassLeft, pClassRight] = GetAnatomyPaths(sSubject, sRegion, sType, sHemisphere, sSubfield);
%
% Get pathnames to gray files and meshes for specified subject and region.
%
% Khan 06/17/2010
% Khan 10/14/2010 - Added region and laminae fields as well as subfield
% return.

%% Default params
if notDefined('sSubject'), sSubject = GetSubject; end
if notDefined('sRegion'), sRegion = 'Cortex'; end
if notDefined('sType'), sType = ''; end
if notDefined('sHemisphere'), sHemisphere = ''; end

%% Argument handling
sSubject = regexprep(sSubject, 'HR', '');

%% Initialize
pAnat =   ExportPath('mri', 'Anatomy', [sSubject, 'HR']);
pRegion = ExportPath('mri', 'Anatomy', [sSubject, 'HR'], sRegion);

%% Main
pGrayLeft  = fullfile(pRegion, 'Left',  [sSubject, 'Left', sType, '.Gray'] );
pGrayRight = fullfile(pRegion, 'Right', [sSubject, 'Right', sType, '.Gray']);
pClassLeft  = fullfile(pRegion, 'Left',  [sSubject, 'HRLeft', sType, '.Class'] );
pClassRight = fullfile(pRegion, 'Right', [sSubject, 'HRRight', sType, '.Class']);
pInner     = fullfile(pRegion, '3DMeshes', ['BothFull', sType, '.mat']);
pOuter     = fullfile(pRegion, '3DMeshes', ['BothFullPia', sType, '.mat']);
pInnerRef  = fullfile(pRegion, '3DMeshes', ['BothFull', sType, 'Refined.mat']);
pOuterRef  = fullfile(pRegion, '3DMeshes', ['BothFullPia', sType, 'Refined.mat']);
pTest  = ExportPath('mri', 'Anatomy', [sSubject, 'HR'], 'TestMeshes');
pBoth  =  fullfile(pRegion, 'Both',  [sSubject, 'HRBoth', sType, '.Class'] );
pBase =   fullfile(pRegion, sHemisphere);
pLaminae = fullfile(pRegion, sHemisphere, 'laminae.mat');
pMesh = fullfile(pRegion, '3DMeshes');
pSurf = fullfile(pAnat, [sSubject, 'HR_FS'], 'surf');

pHemiMesh = fullfile(pRegion, sHemisphere, '3DMeshes');

if nargout == 1 || nargout == 0
    pGrayLeft = struct(...
        'pGrayLeft',    pGrayLeft,  ...
        'pGrayRight',   pGrayRight, ...
        'pInner',       pInner, ...
        'pOuter',       pOuter, ...
        'pInnerRef',    pInnerRef, ... 
        'pOuterRef',    pOuterRef, ...
        'pClassLeft',   pClassLeft, ...
        'pClassRight',  pClassRight, ...
        'pTest',        pTest, ...
        'pLaminae',     pLaminae, ...
        'pHemiMesh',    pHemiMesh, ...
        'pBoth',        pBoth, ...
        'pRegion',      pRegion, ...
        'pMesh',        pMesh, ...
        'pSurf',        pSurf ...
    );
end

if defined('sSubfield')
    pGrayLeft = pGrayLeft.(sSubfield);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
