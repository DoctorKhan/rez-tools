function TestSignedDistanceMap

% TestSignedDistanceMap;
%
%
%
% Khan 02/02/2012
 
%% Default params
HemoInit
cds oSphere
viDim = [349 349 349];

%% Main
oTraj = CalcTrajectories(oSphere, 'White', 'Pia', iGridSize, nSurfaces, '345');

%% Initialize
cd ~
cd Current
%%
oP = ReadRawFileIntoMesh('Pia.raw');
oW = ReadRawFileIntoMesh('White.raw');

%% Check if raw file agrees with mesh files
rw(1) = 45.5;
rp(1) = 52.5;

Destruct oP; rp(2) = mean(Mag(MatrixVectorDiff(vertices, mean(vertices,2))));
Destruct oW; rw(2) = mean(Mag(MatrixVectorDiff(vertices, mean(vertices,2))));

diff(rw)/mean(rw)
diff(rp)/mean(rp)

%% Main
p = reshape(importdata('DumpPia.raw'), viDim);
w = reshape(importdata('DumpWhite.raw'), viDim);

%% Central line
viCent = (viDim + 1)/2;
ciCent = num2cell(viCent(2:end));

p1 = p(viCent(1):end, ciCent{:});

w1 = w(viCent(1):end, ciCent{:});
z1 = zeros(size(w1));

dp = derivative(p1,1);
dw = derivative(w1,1);

viGood = 50:150;

dpp=dp(viGood);
sp=mean(dpp);


x = (1:viCent)*sp - sp;

figure; plot(x, [p1 w1 z1]);
FixFigLimits
xlabel('Euclidean Distance from Sphere Center (mm)')
ylabel('SDF Distance (mm)')

legend('Pia', 'White')

end
%% Note: type "doc hungarian" for variable prefix explanation.
