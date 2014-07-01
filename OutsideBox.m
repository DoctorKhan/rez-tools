function tbOut = OutsideBox(tbMesh, viDim)

% tbOut = OutsideBox(tbMesh);
%
%
%
% Khan 05/28/2012
 
%% Default params
Destruct(tbMesh);
Default viDim = size(tbMesh);

%% Initialize
mBox = BoundingBox(tbMesh);
tbVol = true(viDim);

%% Main
tbOut = isOutside(mBox, tbVol);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
