function [oMesh oHeader] = Surf2VistaFile(oHemo, sHemi, varargin)

% oMesh = Surf2VistaFile(oHemo, sHemi, varargin);
%
%
%
% Khan 07/07/2011

%% Default params
Default varargin = {'Pia'}

%% Initialize
sPrefix = [lower(sHemi(1)) 'h.'];

sName = varargin{end};
if strcmpi(sName, 'Pia')
	sSurf = [sPrefix 'pial'];
else
    sSurf = [sPrefix lower(sName)];
end

varargin{end} = sSurf;
pName = fullfile(varargin{:});
pOut = FileExt(pName, '.mat');

%% Main
FixLinks(oHemo);
pIn  = AnatPath(oHemo, 'Surfaces', sSurf);
pOut = AnatPath(oHemo, sHemi, pOut);

viDim = GetDimFromAnat(oHemo);
mmPerVox = GetVoxelSize(oHemo);
oMesh = ReadFreeSurf(pIn, mmPerVox, viDim);

oMesh.vertices = oMesh.vertices./oMesh.mmPerVox;

if nargout == 0
    SaveMeshVista(oMesh, pOut);
end

end
%% Note: type "doc hungarian" for variable prefix explanation.
