% function TestSphere

%
% n TestSphere;
%
%
%
% Khan 01/02/2012
% Khan 02/14/2012

%% Default params
[x y z] = sphere;
[nx ny nz] = surfnorm(x,y,z);
surfnorm(x,y,z)
%%
s=surf(x,y,z);
set(s, 'VertexNormals', cat(3,nx,ny,nz))
camlight
lighting gouraud

%% Initialize
HemoInit;
Destruct(oSphere);
cds oSphere

maxDepth = 11;
% Left = false(300,300,300);
% Left(:,:,1:150) = true;
% Right = ~Left;
% oMask = Struct(Left, Right);

%% Main
% sHemi = 'Both';
% for csSurf = {'White', 'Pia'}, sSurf = csSurf{1};
% 	pHemi = AnatPath('Sphere', 'Cortex', sHemi, [sSurf '.Class']);
% 	o.(sSurf).(sHemi) = Class2Mesh(pHemi);
% end

%%
[ ~, tDomain ] = Domains4DepthMap(oSphere, nErodeLayers, nExtraLayers);

%%
oTraj = CalcTrajectories(oSphere, 'White', 'Pia', iGridSize, nSurfaces);

%%
oTraj = CalcTrajectories(oSphere, 'White', 'Pia', 350, nSurfaces, 45);
%%
[t m] = ReadThicknessPCD;
%%

%%
maxDepth = 11; nSamples = 'All';
[tDepth, tNormDepth, tbGood, tCurve ] = InterpDepthMap(oSphere, nSamples, maxDepth, vNormBounds);

cent(tDepth)
%%


%%
% [~, R] = SphereVolume(300, 60);
% 
% tReal = R*.7;
% tDiff = tDepth - tReal;
% cent(tDiff)
% [o.White.Both, o.Pia.Both] = CombMeshHemis(oSphere, 'White', 'Pia');

%% Main
pTrajDir = '/export/data/mri/Anatomy/SphereHR/Cortex/Both/White-Pia';

[tCoords, mDepths] = ReadThicknessPCD(pTrajDir, '', '', 'force')%%
m = mDepths;
% vbBad = any(mDepths < 0,3);

%%
t = tCoords - 150.5;
r = squeeze(Mag(t));
rmean = squeeze(mean(Mag(t),2));
%%
tCoords(:,vbBad,:) = [];
mDepths(:,vbBad,:) = [];
%%
Hist(m(1,:,16));
%%
[tCoords, mDepths] = ReadThicknessPCD('', '', '', 'force');
%%
plot3s(tCoords(:,1,:), 'x');
%%
cent(Mesh2Vol(tCoords),2, 135)
%%
maxVal = 11;
tbDomain = tDomain == 2;
t = InterpScattered2Domain(tbDomain, tCoords, mDepths, nSamples, maxVal);
%%
tbCoords = sub2log3d(tCoords, viDim);
c = CombineMatrices(tbCoords, 2*tbDomain);
cent(c)
%%
viDim = size(tbDomain);
vTraj = viDim/2;


viTraj = 200:10:1200;
clear r2

% tTraj = t(:,viTraj,:) - 150.5;
tTraj = tCoords - 150;

r2 = squeeze(Mag(tTraj))';
m = mean(r2,2);
s = std(r2,0,2);
plot(s)
figure; plot(m, 'o')

%%
% viSurfs = [ 1 2 3 7 11 16];
viSurfs = 1:16;
mX = reshape(tCoords(:,:,viSurfs), 3, []);
y = HorzVec(mDepths(:,:,viSurfs));
v = sub2mat3d(mX, y, viDim);
figure; pic(v(:,:,120)); colormap jet;

%%
tb=isfinite(v); 
rmesh = 65.1881;
y = v(tb) + rmesh;

r = RadialCoordinate(v);
x = r(tb); 


xlabel('r (voxels)'); ylabel('dist (mm)');
PolyfitPlot(x, y, 1);
hold on; plot(x, x, 'g');
%%
td = tDepth;
figure; plot(td(:,150,150),'+'); hold on;
plot(tr(:,150,150), 'r')
%%
y = td(:,150,150);
x = tr(:,150,150);
res = y - x;
figure; plot(Finite(res), 'ro'); FixFigLimits;
ylabel('DepthMap - RadialDist (voxels)');
xlabel('Data Pt. (increasing radius)');
%%
tR = RadialCoordinate(300, 150);
[tPx tPy tPz tX tY tZ] = Plaid(tR, 40);
A = 8;
ts = tR + A*tPx.*tPy.*tPz;
cent(ts)
contourslice(ts,[],[],60:5:80,8);
%%
[gx, gy, gz] = gradient(ts);
%%
streamslice(tX,tY,tZ, gx, gy, gz, [],[],10);
%%
ts = ReadDumpIntoVolume('DumpWhite.raw');
%x = ((1:length(t)) - length(t)/2)*300/length(t);
%%
figure
x = 1:length(t);
plot(t(:,175,175), 'x');
hold on; plot(x, zeros(size(x)), 'r');
xlabel('Voxel'); ylabel('SDF');


%%
% [x,y,z] = meshgrid(1:300,1:300,1:300);
% [x,y,z,v] = flow;f

% [x y z ] = Foliate(round(tCoords));
% y = HorzVec(mDepths);
% x = sub2ind3d(tCoords,viDim);
% y = GridData(x, mDepths(:), [], [], 20);


% p = patch(isosurface(x,y,z,v,1.25));
% isonormals(x,y,z,v,p)
% set(p,'FaceColor','red','EdgeColor','none');
% daspect([1 1 1])
% view(3); axis tight
% camlight
% lighting gouraud

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
