function TestClass2Mesh

% TestClass2Mesh;
%
%
%
% Khan 01/27/2012
 
%% Default params


%% Initialize
pHemi = AnatPath('Sphere', 'Cortex', 'Both', 'Pia.Class');

%% Main
oClass = readClassFile(pHemi);
tbWhite = oClass.data == oClass.type.white;
mWhite = log2sub3d(tbWhite);

%%
oMesh = Class2Mesh(pHemi);
%%
mMesh = oMesh.vertices./oMesh.mmPerVox;
mean(mWhite,2)
mean(mMesh,2)

%%

sl = mMesh(1:2,abs(mMesh(3,:) - 150) < 0.5);
cent(tbWhite)
hold on; plot(sl(1,:), sl(2,:), '.');
% SliceMeshOnVolume(oMesh, tbWhite)
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
