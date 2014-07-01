function [m s t] = InterpMeshOnVol(oMesh, oVol)

% meanVal = InterpMeshOnVol(oMesh, oVol, sType);
%
%
%
% Khan 03/28/2012

%% Default params

%% Initialize
Destruct(oMesh);
oVol.Update;
Destruct(oVol);

Default iType = 1;
Default sType = "data"
%% Main
if strcmpi(sType, 'white')
    tData = tSeg;
end

vData = VertVec(abs(interp3(tX, tY, tZ, tData, vertices(1,:), vertices(2,:), vertices(3,:))));

[m s t] = mss(vData, iType);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
