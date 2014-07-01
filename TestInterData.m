% function TestInterData

% TestInterData;
%
%
%
% Khan 03/04/2012

%% Default params


%% Initialize

%% Main
[t400, mBox, vScale] = ReadRawiv('White400.rawiv');
oMesh400 = isomesh(t400,0); Destruct oMesh400
mC = MatrixVectorSum(MatrixVectorProd(vertices - 1,vScale), mBox(1,:)) - 150.5;
%%
[gx gy gz] = gradient(oRawiv.tData);


%%
clear v

[x y z] = meshgrid(1:300);
%%
[ux, uy, uz] = Foliate(mCoords, @unique); clear('mCoords');
[xx, yy, zz] = meshgrid(ux, uy, uz);

viDim = GetDimFromAnat;

if notDefined('tG')
    tic
    Str('Interpolating grid...')
    [nx ny nz] = Foliate(viDim);
    [x y z] = meshgrid(1:nx, 1:ny, 1:nz);
    tG = interp3(xx, yy, zz, tData, x, y, z);
    toc
end

%%
TestNormBall
%% Check Radii from rawiv and mesh files
TestRadius
%%
TestNormals(oMesh)
%%
iSurf = 0;
oMesh = ReadRawFileIntoMesh(St('Inter400s', iSurf, '.raw'));
oMesh2 = meshRefine(oMesh,1);

%% plot normals
r = vMag;
c = colormap('jet')';
n = round(normalize(r)*63 + 1);
colors = c(:,n);
oMesh.colors = colors;
SaveMeshRawc(oMesh, 'SDFCheck.rawc');

%% Note: type "doc hungarian" for variable prefix explanation.
