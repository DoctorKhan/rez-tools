% function TestStepTraject

% TestStepTraject;
%
%
%
% Khan 03/05/2012
 
%% Default params


%% Initialize
Str('Reading files...'); tic;
oRawiv = ReadRawiv('Inter300s6.rawiv', 'struct'); Destruct oRawiv
oMesh = ReadRawFileIntoMesh('Inter400s5.raw');
oMesh2 = ReadRawFileIntoMesh('Inter400s6.raw'); 
toc

d = mean(Mag(oMesh2.vertices - 150.5)) - mean(Mag(oMesh.vertices - 150.5))
%% Main
tic
[oMesh oMesh2] = StepTraject(oMesh, oMesh2, oRawiv); 
toc
Destruct oMesh
%%

d = Mag(vertices + normals - 150.5) - Mag(vertices - 150.5);
[mean(d) std(d)]

%%

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
