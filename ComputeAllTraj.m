function ComputeAllTraj(voHemo)

% ComputeAllTraj(voHemo);
%
%
%
% Khan 05/01/2012

%% Default params


%% Initialize
HemoInit

%% Main
for oHemo = voHemo
%     ComputeSdf(oHemo, 'save');
%     CombineSdfHemis(oHemo);
%     ComputeNormSdf(oHemo);
    ComputeTraject(oHemo, 'save');
    CombineTrajectHemis(oHemo);
    ComputeTrajectNorm(oHemo);
end
end % Function
%     % Output
%     pLaminae = fullfile(fileparts(oSdfWhite.filename), 'Laminae');
%     Str('Saving maps to', pLaminae);
%     Save(pLaminae, tWdepth, tWthick, tWcurve, tbDomain);


%% Note: type "doc hungarian" for variable prefix explanation.
