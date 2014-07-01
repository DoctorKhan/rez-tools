function TestMeshGrid2

% TestMeshGrid2;
%
%
%
% Khan 04/03/2012
 
%% Default params


%% Initialize
t = cat(3,SampleTS, SampleTS);
mG = MeshGrid2(t);
mCoords = VertVec(mG./log2sub3d(t));
mss(mCoords);

[xg,yg,zg] = MeshGrid2(t, [0.5 0.4 0.3]);
vSize = size(xg)./size(t);
mss(vSize);

x = HorzVec(xg(:,1,1));
y = HorzVec(yg(1,:,1));
z = HorzVec(zg(1,1,:));

%% Main
mss(diff(x), 'vSp1');
mss(diff(y), 'vSp2');
mss(diff(z), 'vSp3');

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
