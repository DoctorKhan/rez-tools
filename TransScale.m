function oRaw = TransScale(oRaw, vTrans, vScale)

% oRaw = TransScale(oRaw, vTrans, vScale);
%
%
%
% Khan 04/09/2012

%% Default params
try
Default vTrans = oRaw.vTrans;
end

Default vScale = [1 1 1];
Default vTrans = [1 1 1].*vScale;

%% Initialize
if isObStruct(oRaw)
    try oRaw.UnitsOff; end
    vertices = oRaw.vertices;
else
    vertices = oRaw;
end
    
%% Main
vertices(1,:) = (vertices(1,:) + vTrans(1))* vScale(1);
vertices(2,:) = (vertices(2,:) + vTrans(2))* vScale(2);
vertices(3,:) = (vertices(3,:) + vTrans(3))* vScale(3);

%% Output
if isObStruct(oRaw)
    oRaw.vertices = vertices;
else
    oRaw = vertices;
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
