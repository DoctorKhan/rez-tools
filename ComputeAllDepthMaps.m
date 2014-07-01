function ComputeAllDepthMaps(voHemo)

% ComputeAllDepthMaps(voHemo);
%
%
%
% Khan 05/01/2012
 
%% Default params


%% Initialize
HemoInit

%% Main

ComputeAllSdfs(voHemo);
ComputeTrajectAll(voHemo);
NormalizeAllDepthMaps(voHemo);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
