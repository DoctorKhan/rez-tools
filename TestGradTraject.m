function TestGradTraject
% TestGradTraject;
% Khan 05/22/2012

%% Initialize
HemoInit

% Main
pLeft = AnatPath(oGreene, 'Left', 'GreeneLeftWhite.raw');
oLeft = RawMesh(pLeft);
oPial = RawMesh(AnatPath(oGreene, 'Left', 'GreeneLeftPia.raw'));

%
tW = Load(AnatPath(oGreene, 'Left', 'Laminae.mat'), 'distance');
viBounds = [-1 2]; nSteps = 40; maxDepth = 7;

[tTraj vSdf] = GradTraject(oLeft, tW, nSteps);
%%
[mCoords, vDepth, vThick] = Traj2Depth(tTraj, tW, maxDepth, oPial);

tbDomain = tW > viBounds(1) & tW < viBounds(2);
tic; tDist  = DistGrid(mCoords, vDepth, tbDomain); toc;
tic; tThick = DistGrid(mCoords, vThick, tbDomain); toc;

%%
% s.GradDist;
end
%% Note: type "doc hungarian" for variable prefix explanation.
