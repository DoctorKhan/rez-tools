function oRawiv = SignedDistFunc(oRaw, viDimFull, varargin)

% oRawiv = SignedDistFunc(pInRaw, threshold, viDim, mBox(1,:));
%
%
%
% Khan 04/22/2012

%% Default params
Default viLowerLim = [1 1 1];
Default threshold = Inf
Default viDimFull = oRaw.viDim;
Default viDimFull = GetDimFromAnat;

Destruct(viDimFull, 'weakly');
viDim = viDimFull;

%% Arg handling
oRaw = RawMesh(oRaw);
pInRaw = oRaw.Save(TempFile('.raw'), 'vertices');

%% Initialize
pOutRawiv = TempFile('.rawiv');
ciDim = num2cell(HorzVec(viDim));

%% Main
% Execute SDF command
sCommand = Str('FastSign', pInRaw, ciDim{:}, pOutRawiv);
iError = system(sCommand);

if iError
    fprintf('FastSignDist error: ');
    error(sCommand);
end

% Cleanup
rm(pInRaw);
oRawiv = Rawiv(pOutRawiv); rm(pOutRawiv);
oRawiv.viDimFull = viDimFull;

oRawiv.filename = FileExt(oRaw, 'Sdf.rawiv');
oRawiv.threshold = threshold;

%% Optional
GetOpts('align','full', 'slice', 'fix');
if bFix,   oRawiv.tData = FixSdf(oRawiv.tData, threshold); end
if bAlign, oRawiv.Align2Mesh(oRaw); end % Required adjustment.
if bFull,  oRawiv.InterpFull; end
if bSlice, SliceMeshOnVolume(oRaw, oRawiv.tData, 2); end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
