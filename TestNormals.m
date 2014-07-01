function TestNormals(oMesh)

% TestNormals;
%
%
%
% Khan 03/19/2012
 
%% Default params


%% Initialize
Default oMesh = RawMesh('Inter300s', 0);


%% Main
oG = RawMesh(oMesh);
oS = RawMesh(oMesh);
oS.NormSurf;
oG.NormGrad;
r = sum(oS.normals.*oG.normals);
DegreeDiff = real(acos(r))*180/pi;
mss(DegreeDiff)
Hist(DegreeDiff);

NormBall(oS); hold on; 
NormBall(oG, '', 'r.', 'g')


end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
