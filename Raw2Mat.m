function Raw2Mat(oMesh, pFile, varargin)

% Raw2Mat(oMesh, varargin);
%
%
%
% Khan 06/12/2012
 
%% Default params
if defined('pFile')
    oMesh.filename = pFile;
end

%% Initialize
oMesh = RawMesh(oMesh);
oMesh.filename = FileExt(oMesh.filename, '.mat');
SaveMeshVista(oMesh, varargin{:});

%% Main


end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
