function oRaw = MeshNormSurf(oRaw, oRawiv, varargin)

% oRaw = MeshNormSurf(oRaw, oRawiv, varargin);
%
%
%
% Khan 04/09/2012

%% Default params


%% Initialize


%% Main
if ~(isField(oRaw, 'normtype', 'surf') && isField(oRaw, 'normsrc', 'meshRefine'))
    oRaw = meshRefine(oRaw, 0);
    
    oRaw.normtype = 'surface';
    oRaw.normsrc = 'meshRefine';
end

if defined('oRawiv')
    oRaw = FixMeshNormals(oRaw, oRawiv, varargin{:});    
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
