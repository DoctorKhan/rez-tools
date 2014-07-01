function oMesh = AlignCenter(oMesh, oVol, varargin)

% oMesh = AlignCenter(oMesh, oVol, varargin);
%
% Align center of a mesh and volume
%
% Khan 04/26/2012

%% Default params

%% Initialize
oMesh = RawMesh(oMesh); oVol = Rawiv(oVol);
MeshTransErr([0 0 0], oMesh, oVol);

%% Main
vDiff{1} = [0 0 0];
vDiff{2} = mean(oVol.Box) - mean(oMesh.Box);
vDiff{3} = mean(log2sub3d(oVol.tData),2) - nanmean(oMesh.vertices,2);

vError = CellFun(@MeshTransErr, vDiff);

vbOptimal = vError == min(vError(vError > 0));
oMesh.Translate(vDiff{vbOptimal});

if nargout == 0
    SliceMeshOnVolume(oMesh, oVol);
end

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
