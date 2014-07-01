function tSdf = FixSignsFlood(tSdf, viStop)

% tSdf = FixSignsFlood(tSdf);
%
%
%
% Khan 05/28/2012

%% Default params
Default viStop = [-1 1]

%% Initialize
oQual = SdfQa(tSdf); % Quality check

%% Main
tbMesh = tSdf < viStop(2) & tSdf > viStop(1);

tbEdge = OutsideBox(tbMesh) & ~tbMesh;
tbPos = Dilate3D(tbEdge, 1, tbMesh);

tbPos = Dilate3D(tbPos, 50000, tbMesh | tbEdge) | tbEdge;
tSdf(tbPos) = abs(tSdf(tbPos));

tbEdge2 = tbPos | tbMesh;
tbNeg = Dilate3D(tbEdge2, 1, tbEdge2);

tbNeg = Dilate3D(tbNeg, 50000, tbEdge2);
tSdf(tbNeg) = -abs(tSdf(tbNeg));

%% Quality check
SdfQa(tSdf, oQual); % Quality check

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
