function ComputeTrajectAll(voHemo)

% ComputeTrajectAll(voHemo);
%
%
%
% Khan 06/18/2012

%% Default params


%% Initialize
HemoInit

%% Main
for oHemo = voHemo
    for oHemi = voHemis
        ComputeTraject(oHemo, oHemi);
    end
    CombineTrajectHemis(oHemo);
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
