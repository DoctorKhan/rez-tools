function [oInnerMesh, oOuterMesh] = GetBothMesh(sSubject, sRegion, sRefined)

% [oInnerMesh, oOuterMesh] = GetMesh(sSubject, sRegion, sRefined);
%
% Return the meshes
%
% Khan 07/02/2010

%% Default params
if notDefined('sSubject'), sSubject = 'Khan'; end
if notDefined('sRegion'), sRegion = 'Cortex'; end
if notDefined('sRefined'), sRefined = 'refined'; end

%% Initialize

%% Main
AnatPath(sSubject, sRegion, 
[dummy, dummy, pInner, pOuter, pInnerRefined, pOuterRefined] = GetAnatomyPaths(sSubject, sRegion);

if strcmpi(sRefined, 'refined')
    pInner = pInnerRefined; pOuter = pOuterRefined;
end

oInnerMesh = readMesh(pInner);

if nargout == 2
    oOuterMesh = readMesh(pOuter);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
