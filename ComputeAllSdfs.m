function ComputeAllSdfs(voHemo)

% ComputeAllSdfs(voHemo);
%
%
%
% Khan 05/01/2012

%% Default params


%% Initialize
HemoInit

%% Main
for oHemo = voHemo
    ComputeSdf(oHemo, 'save');
    CombineSdfHemis(oHemo);
    ComputeNormSdf(oHemo);
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
