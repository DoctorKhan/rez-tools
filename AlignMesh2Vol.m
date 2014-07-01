function [oMesh vAdj LastError] = AlignMesh2Vol(oMesh, oVol, varargin)

% [oMesh vAdj LastError] = AlignMesh2Vol(oMesh, oVol, varargin);
%
%
%
% Khan 03/23/2012

%% Initialize
if isMesh(oVol), [oMesh, oVol] = swap(oMesh, oVol); end

oVol = Rawiv(oVol);
if numel(unique(oVol.tData(:))) == 2
    v = minmax(oVol.tData);
    oVol.tData = oVol.tData == v(2);
end

%% Main
oMesh = AlignCenter(oMesh, oVol);
% oMesh = PermuteAlign(oMesh, oVol);
% oMesh = AlignCenter(oMesh, oVol);
oBox = CheckBoundBox(oMesh, oVol)

% Prepare for alignment fitting routine
if islogical(oVol.tData)
    tic; oVol.tData = SegMap(oVol.tData, 50); toc
end

InitialError = MeshTransErr([0 0 0], oMesh, oVol);
if nanmean(InitialError) < 0.3
    Str('Mesh is aligned to volume. Nothing to do.');
    vAdj = [0 0 0];
    LastError = InitialError;
    return;
end

Str('Aligning mesh and volume...'); tic
mss(InitialError);

% Align by fitting
v0 = [ 0 0 0 ];
[vAdj, LastError] = fminsearch(@MeshTransErr, v0);
Str('Final mesh to volume adjustment:', vAdj);  toc;

%% Output
deltaError = InitialError - LastError;

if deltaError > 0
    oMesh = oMesh.Translate(vAdj);
    
    perRelChange = 100*deltaError/InitialError;
    Str(perRelChange, '% improvement.');
    mss(LastError);
else
    Str('Could not align.');
end

try
    SliceMeshOnVolume(oMesh, oVol);
catch ME, Str(ME);
    %     keyboard
end

%% Cleanup
if Option('save'), oMesh.Save; end
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
