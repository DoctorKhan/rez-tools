function CalcAllTrajectories(voHemo)

%
% CalcAllTrajectories(voHemo);
%
%
%
% Khan 07/07/2011

%% Main
nSubjects = length(voHemo);
HemoInit

for ii = 1:nSubjects
    sSubject = voHemo(ii).sSubject;
    CalcTrajectories(sSubject, 'Cortex', 'Left',  'White.obj', 'Pia.obj', iGridSize, nSurfaces);
    CalcTrajectories(sSubject, 'Cortex', 'Right', 'White.obj', 'Pia.obj', iGridSize, nSurfaces);
end
end
%% Note: type "doc hungarian" for variable prefix explanation.
