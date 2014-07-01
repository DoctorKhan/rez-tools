function oMesh = VertexNormals(oMesh)

% [mD, angle, mN, mA, mB, mC, mNA, mNB, mNC] = VertexNormals(oMesh);
%
% Calculate the triangle surface vector normals from the vertex normals
%
% Khan 03/02/2010

%% Default params
%% Initialize
[triangles, vertices] = Destruct(oMesh);

%% Main
mT = triangles + 1;

[mA mB mC] = Foliate(reshape(vertices(:, mT), 3, 3, []), '', 2);
mD = cross((mB - mA), (mC - mA));
mD = NormalizedVector(mD);
% oMesh.
%% Vertex normals
mCent = (mA + mB + mC) /3;
mNA = mD(:,mT);

% mV = mD(:, 

mN = (mNA + mNB + mNC) / 3;
% mN = NormalizedVector(mN);
% 
% vDot = dot(mN,mD);
% 
% vbBad = vDot < 0;
% mbBad = repmat(vbBad, 3, 1);
% mD(mbBad) = -mD(mbBad);

fnormals = mD;
end %function


%% Note: type "doc hungarian" for variable prefix explanation.
