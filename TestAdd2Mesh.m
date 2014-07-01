% function TestAdd2Mesh

% TestAdd2Mesh;
%
%
%
% Khan 02/08/2012
 
%% Default params


%% Initialize
HemoInit

%% Main
cds oGreene
cd Anat/Left/3DMeshes/White-Pia
n = 3;
vi = zeros(1,n);
m = mPia;

[tC, mDepths] = ReadThicknessPCD;
%%
m16 = tC(:,:,16);
v16 = mDepths(1,:,16);
ip = 1;
p = m16(:,ip); m16(:,ip) = deal(nan);
mTriangles = oPia.triangles;
%%
[vd, vid] = sort(mag(MatrixVectorDiff(m16, p)));
%%
vc = 'bgy';
for ii = 1:3
	vid(ii)
	mSubTri = mTriangles(:,any(mTriangles == vid(ii)));
	for iTri = 1:size(mSubTri,2)
		viTri = mSubTri([1 2 3 1], iTri);
		plot3s(m16(:,viTri)', [vc(ii) 'o-']); hold on;
	end
	plot3s(m16(:,vid(ii)), 'ro');
	plot3s(p, 'rx');
end
%%


mNear = mPia(:,vi);
figure; plot3s(mNear, 'o'); hold on
plot3s(p, 'ro')

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
