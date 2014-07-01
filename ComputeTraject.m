function ComputeTraject(oHemo, sHemi)

% ComputeTraject;

% Khan 05/22/2012
% Khan 06/18/2012

%% Initialize
HemoInit
if defined('sHemi')
    Destruct sHemi
end

Destruct oHemo weakly;

% Main
oWhite = RawMesh(AnatPath(oHemo, sHemi, [sSubject sHemi 'White.raw']));
oPial  = RawMesh(AnatPath(oHemo, sHemi, [sSubject sHemi 'Pia.raw']));
pLaminae = AnatPath(oHemo, sHemi, 'Laminae.mat');

%
tW = Load(AnatPath(oHemo, sHemi, 'Laminae.mat'), 'tW');
if isempty(tW)
    tW = Load(pLaminae, 'distance');
end

viBounds = [-1 2]; nSteps = 40; maxDepth = 7;

tTraj = GradTraject(oWhite, tW, nSteps);
%%
[mCoords, vDepth, vThick] = Traj2Depth(tTraj, tW, maxDepth, oPial);

tbDomain = tW > viBounds(1) & tW < viBounds(2);
tic; distance  = DistGrid(mCoords, vDepth, tbDomain); toc;
tic; thickness = DistGrid(mCoords, vThick, tbDomain); toc;

normdepth = distance./thickness;
%% Output
Str('Saving maps to', pLaminae);
Save(pLaminae, distance, thickness, normdepth, 'append');

end
%% Note: type "doc hungarian" for variable prefix explanation.
