function [oVol, vAdj, FinalError] = AlignVol2Mesh(oVol, oMesh, varargin)

% [oVol, vAdj, FinalError] = AlignVol2Mesh(oVol, oMesh, varargin);
%
%
%
% Khan 03/23/2012

%% Default
Default oMesh.filename = oVol.filename(1:end-2)
            
%% Initialize
if isMesh(oVol), [oMesh, oVol] = swap(oMesh, oVol); end

oMesh.UnitsOff;
oMesh.oVolume = oVol;
oMesh.Verts;

InitialError = MeshTransErr([0 0 0], oMesh, oVol);
mss(InitialError);

%% Main
Str('Aligning volume to mesh...'); tic;
v0 = AlignCenter(oVol, oMesh, 'bounds');

[vAdj, FinalError] = fminsearch(@MeshTransErr, v0);
Str('Final volume to mesh adjustment:', -vAdj);  toc;
mss(FinalError);

oVol  = oVol.Translate(-vAdj);
%% Cleanup
if Option('save'), oVol.Save; end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
