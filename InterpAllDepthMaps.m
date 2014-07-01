function InterpAllDepthMaps(voHemo, voHemis, nSamples)

% InterpAllDepthMaps(voHemo);
%
%
%
% Khan 07/10/2011

%% Defaults
HemoInit

%% Main
for oHemo = voHemo        
    for oHemi = voHemis
        [ ~, ctbDomain ] = Domains4DepthMap(oHemo, sHemi, nErodeLayers, nExtraLayers, tbMask, varargin);
        
        [ tDepth, tNormDepth ] = InterpDepthMap(oTraj, oHemo, oMesh);
        max([tDepth(:) tNormDepth(:)])
        min([tDepth(:) tNormDepth(:)])
    end
end

%% Note: type "doc hungarian" for variable prefix explanation.
