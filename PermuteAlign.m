function oMesh = PermuteAlign(oMesh, oVol)

% oMesh = PermuteAlign(oMesh, oVol);
%
%
%
% Khan 06/20/2012

%% Default params


%% Initialize
mVerts0 = oMesh.vertices;
c = nanmean(mVerts0,2);

miPerm = [...
    2 1 3; ...
    3 1 2; ...
    2 3 1; ...
    1 3 2; ...
    3 2 1; ...
    2 3 1; ...
    1 2 3;
    ]';

miFlip = [...
    -1 -1 -1;...
    1 -1 -1;...
    -1 1 -1;...
    -1 -1 1;...
    -1 1 1;...
    1 -1 1;...
    1 1 -1;...
    1 1 1;...
    ]';

%% Main
MeshTransErr([0 0 0], oMesh, oVol);
e0 = MeshTransErr([0 0 0]);

m = mVerts0 - c;
for viPerm = miPerm
   
    for viFlip = miFlip
        oPerm.vertices = viFlip.*m(viPerm,:) + c;
        oCheck = CheckBoundBox(oPerm, oVol);
        if ~oCheck.aligned(1)
            continue
        end
        e1 = MeshTransErr([0 0 0]);
        if e1 < e0 && e1 > 0
            oMesh.vertices = oPerm.vertices;
            e0 = e1;
        end
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
